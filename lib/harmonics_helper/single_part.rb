module HarmonicsHelper

  # information about single part
  class SinglePart

    # initialize
    def initialize(sounds)
      @sounds = sounds
    end

    # get sounds include durations info
    #
    # @param [Array] duration
    # @return [Array] sounds array repeated sound where duration is over 2
    def full_sounds(durations)
      @sounds.map.with_index { |sound, index| Array.new(durations[index], sound) }
        .flatten
    end

    # get progression of single part
    # if elements is nil, progression number consider as 0
    #
    # @return [Array] diff of neiboring sounds as number array
    def progression()
      progression_common(@sounds)
    end

    # get full progression of single part include duration info
    # if elements is nil, progression number consider as 0
    #
    # @return [Array] diff of neiboring sounds as number array
    def full_progression(durations)
      full_sounds = full_sounds(durations)
      progression_common(full_sounds)
    end

    private
    # get progression common
    def progression_common(sounds)
      sounds.map.with_index { |sound, index| (sounds.rotate(1)[index].nil? || sound.nil?)? 0 : sounds.rotate(1)[index] - sound }
        .select.with_index{ |diff, index| index!=sounds.length-1 } # last element is not required
    end

  end
end
