require "harmonics_helper/part/part"


module HarmonicsHelper

  module Part

    # information about single part
    class SinglePart
      include PartModule
      include Validators

      # initialize
      def initialize(sounds, durations)
        durations_validator(sounds, durations)
        @sounds = sounds
        @durations = durations
      end

      # get sounds include durations info
      #
      # @return [Array] sounds array repeated sound where duration is over 2
      def full_sounds()
        full_sounds_base(@sounds, @durations)
      end

      # get progression of single part
      # if elements is nil, progression number consider as 0
      #
      # @return [Array] diff of neiboring sounds as number array
      def progression()
        progression_base(@sounds)
      end

      # get full progression of single part include duration info
      # if elements is nil, progression number consider as 0
      #
      # @return [Array] diff of neiboring sounds as number array
      def full_progression()
        progression_base(full_sounds)
      end

    end

  end

end
