require "harmonics_helper/etc/exceptions"

module HarmonicsHelper

  # deal with part
  module PartModule

    # get progression
    # base method
    #
    # @params [Array] sounds
    # @return [Array] progression as number array
    def progression_base(sounds)
      sounds.map.with_index { |sound, index| (sounds.rotate(-1)[index].nil? || sound.nil? || index==0)? 0 : sound - sounds.rotate(-1)[index] }
    end

    # get sounds include durations info
    # base method
    #
    # @return [Array] sounds array repeated sound where duration is over 2
    def full_sounds_base(sounds, durations)
      sounds.map.with_index{ |sound, index| Array.new(durations[index], sound) }
        .flatten
    end

    # full sounds hash has sounds and order information
    # base method
    #
    # @return [Array] sounds and order(count), each element is hash
    def full_sounds_hash_base(sounds, durations)
      # order is number for user, start with 1
      sounds.map.with_index{ |sound, index| Array.new(durations[index], { "sound" => sound, "order" => index + 1 })}
        .flatten
    end

    # if sounds and durations is different size, raise Error
    def durations_validator(sounds, durations)
      if sounds.length != durations.length then
        raise DurationUnmatchError(31, "sounds length is different from durations length")
      end
    end
  end

end