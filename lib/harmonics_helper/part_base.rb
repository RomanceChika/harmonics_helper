require "harmonics_helper/etc/exceptions"

module HarmonicsHelper

  # base class of parts
  class PartBase

    protected
    # get progression common
    def progression_common(sounds)
      sounds.map.with_index { |sound, index| (sounds.rotate(1)[index].nil? || sound.nil?)? 0 : sounds.rotate(1)[index] - sound }
        .select.with_index{ |diff, index| index!=sounds.length-1 } # last element is not required
    end

    # get sounds include durations info
    # base method
    #
    # @return [Array] sounds array repeated sound where duration is over 2
    def full_sounds_base(sounds, durations)
      sounds.map.with_index { |sound, index| Array.new(durations[index], sound) }
        .flatten
    end

    # get progression of part
    # if elements is nil, progression number consider as 0
    # base method
    #
    # @return [Array] diff of neiboring sounds as number array
    def progression_base(sounds)
      progression_common(sounds)
    end

    # if sounds and durations is different size, raise Error
    def durations_validator(sounds, durations)
      if sounds.length != durations.length then
        raise DurationUnmatchError(31, "sounds length is different from durations length")
      end
    end

  end

end