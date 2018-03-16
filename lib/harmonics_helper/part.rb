require "harmonics_helper/etc/exceptions"

module HarmonicsHelper

  # deal with part base module
  module PartModule

    # get progression
    #
    # @params [Array] sounds
    # @return [Hash] progression hash about sound and direction 
    def progression_base(sounds)
      progression = {}
      sounds.each_with_index do |sound, index| 
        progression[index] = {}
        if sounds.rotate(-1)[index].nil? || sound.nil? || index==0
          progression[index]["sound"] = sound
          progression[index]["progress"] = 0
          progression[index]["direction"] = true
        else
          progression[index]["sound"] = sound
          progression[index]["progress"] = sound - sounds.rotate(-1)[index]
          progression[index]["direction"] = (progression[index]["sound"] - progression[index-1]["sound"] >= 0)
        end
      end
      progression
    end

    # get distance of intervals in octave
    #
    # @param [Hash] intervals
    # @return [Array] intarvals number array in octave ranges
    def distance_base(intervals)
      intervals.values.map { |value| value["sound"] % 12 }
    end

    # get sounds include durations info
    #
    # @return [Array] sounds array repeated sound where duration is over 2
    def full_sounds_base(sounds, durations)
      sounds.map.with_index{ |sound, index| Array.new(durations[index], sound) }
        .flatten
    end

    # full sounds hash has sounds and order information
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