require "harmonics_helper/part/part"
require "harmonics_helper/code/rotations"

module HarmonicsHelper

  module ProhibitCheckerModule
    include Part::PartModule

    # check if harmony makes code?
    #
    # @param [Array] rotation
    # @return [Boolean] is code true
    def code?(rotation)
      rotation.empty? ? false : true
    end

    # check conencutive octave or fifth
    #
    # @param [Array] progression
    # @return [Array] prohibit as boolean array
    def conencutive_prohibit(progression)
      progression.to_a.map do |key, progress| 
        if progress["direction"] && key!=0 && progress["progress"]==0 && ( progress["sound"] % 12 == 0 || progress["sound"] % 12 == 7 )
          true
        else
          false
        end
      end
    end

    # implement check hidden octave or fifth
    # TODO: should be had test
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

    # TODO: Single part's big jump progress should be alerted
    # TODO: Naibor Pair parts, should be between 8 degrees (case bass 12)
    # TODO: Distribution conversion should be alerted 

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
    end

    # check concencutive prohibits all pair
    #
    # @return [Array] prohibit boolean 2 dimension arrays
    def concencutive_prohibits_all()
      @parts.combination(2).map { 
        |part1, part2|
        conencutive_prohibit(
         Part::PairParts.new(@parser.sounds(part1), @parser.durations(part1), @parser.sounds(part2), @parser.durations(part2))
          .intervals_progression
        )
      }
    end

    # check hidden octave and fifth between soprano and bass
    # TODO: decide soprano and bass automatic, don't hard cord
    # TODO: make test code
    #
    # @return [Array] prohibit boolean arrays 
    def hidden_prohibit_all()
      hidden_prohibit(Part::PairParts.new(@parser.sounds(1), @parser.durations(1), @parser.sounds(6), @parser.durations(6)).intervals_progression)
    end

    # check code confighred 
    # TODO: if non harmonic tone is include,it is not prohibit ,alert
    # 
    # @return [Array] prohibit boolean arrays
    def code_configured_all()
      @rotations.rotation_types.map { |rotation_type| code?(rotation_type) }
    end

  end

end