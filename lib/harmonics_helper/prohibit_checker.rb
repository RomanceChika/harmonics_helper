require "harmonics_helper/part"
require "harmonics_helper/code/rotations"

module HarmonicsHelper

  module ProhibitCheckerModule
    include PartModule

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

    def concencutive_prohibits_all()
      @parts.combination(2).map { 
        |part1, part2|
        conencutive_prohibit(
         PairParts.new(@parser.sounds(part1), @parser.durations(part1), @parser.sounds(part2), @parser.durations(part2))
          .intervals_progression
        )
      }
    end





  end


end