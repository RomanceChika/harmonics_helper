require "harmonics_helper/part"

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
    # @param [Array] rotation
    #
    def conencutive_prohibit(progression)
      progression.to_a.map do |key, progress| 
        if progress["direction"] && key!=0 && progress["progress"]==0 && ( progress["sound"] % 12 == 0 || progress["sound"] % 12 == 7 )
          true
        else
          false
        end
      end
    end

    # TODO: implement check hidden octave or fifth

  end

  class ProhibitChecker
    extend ProhibitCheckerModule

    def initialize

  end


end