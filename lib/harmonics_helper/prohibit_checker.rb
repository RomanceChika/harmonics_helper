require "harmonics_helper/etc/validators"
require "harmonics_helper/part/part"
require "harmonics_helper/code/rotations"

module HarmonicsHelper

  module ProhibitCheckerModule
    include Part::PartModule
    include Validators

    # check if harmony makes code?
    #
    # @param [Array] rotation
    # @return [Boolean] is code true
    def code?(rotation)
      rotation.empty? ? false : true
    end

    # check consective octave or fifth
    #
    # @param [Array[Array[Hash]]] pair
    # @return [Array[Boolean]] boolean true has prohibit
    def consecutive_prohibit(pair)
      array_size_validator(pair, 2)
      same_length_validator(pair[0], pair[1])
      common_length = pair[0].length
      common_length.times.map do |index|
        distance = distance_base(pair[0][index]["sound"], pair[1][index]["sound"]) 
        parallel_motion = (pair[0][index]["progress"]  == pair[1][index]["progress"] && pair[0][index]["progress"] != 0)
        ((distance % 12 == 0 || distance % 7 == 0) && parallel_motion) ? true : false
      end
    end

    # implement check hidden octave or fifth
    # TOD: should be had test
    #
    # @param [Array] progression
    # @return [Array] prohibit as boolean array
    def hidden_prohibit(progression)
      progression.to_a.map do |key, progress| 
        if progress["direction"] && key!=0 && progress["progress"]>=3 && [0, 7].include?(progress["sound"] % 12 )
          true
        else
          false
        end
      end
    end

    # TOD: Single part's big jump progress should be alerted
    # TOD: Naibor Pair parts, should be between 8 degrees (case bass 12)
    # TOD: Distribution conversion should be alerted 

  end

  class ProhibitChecker
    include ProhibitCheckerModule

    # initialize
    #
    # @param [Parser] xml parser class
    def initialize(parser)
      @parser = parser
      @parts = parser.parts
      @full_sounds = @parts.map { |part| @parser.sounds(part) }
      @rotations = Code::Rotations.new(@full_sounds)
      @four_parts = Part::FourParts.new(parser)
    end

    # check consencutive prohibits all pair
    #
    # @return [Array] prohibit boolean 2 dimension arrays
    def consecutive_prohibits_all()
     @four_parts.all_pairs.map { |pair| consecutive_prohibit(pair) }
    end

    # check hidden octave and fifth between soprano and bass
    # TOD: implement
    #
    # @return [Array] prohibit boolean arrays 
    def hidden_prohibit_all()
    end

    # check code confighred 
    # TOD: if non harmonic tone is include,it is not prohibit ,alert
    # 
    # @return [Array] prohibit boolean arrays
    def code_configured_all()
      @rotations.rotation_types.map { |rotation_type| code?(rotation_type) }
    end

  end

end