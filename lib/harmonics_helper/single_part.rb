require "harmonics_helper/part"

module HarmonicsHelper

  # information about single part
  class SinglePart
    include PartModule

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
      progression_common(full_sounds)
    end

  end

end
