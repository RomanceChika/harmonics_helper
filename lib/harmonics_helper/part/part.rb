require "harmonics_helper/etc/exceptions"
require "harmonics_helper/etc/validators"

module HarmonicsHelper

  module Part
  
    # deal with part base module
    module PartModule
      include Validators

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
          else
            progression[index]["sound"] = sound
            progression[index]["progress"] = sound - sounds.rotate(-1)[index]
          end
        end
        progression
      end

      # get distance of intervals in octave
      #
      # @param [Integer] sound1
      # param [Integer] sound2
      # @return [Array] distance number array in octave ranges
      def distance_base(sound1, sound2)
        (sound1 - sound2).abs % 12
      end

      # get sounds include durations info
      #
      # @return [Array] sounds array repeated sound where duration is over 2
      def full_sounds_base(sounds, durations)
        sounds.map.with_index{ |sound, index| Array.new(durations[index], sound) }
          .flatten
      end

    end

  end

end