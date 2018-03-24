require "yaml"
require "harmonics_helper/etc/path_helper"
require "harmonics_helper/etc/validators"

module HarmonicsHelper

  module Code

    # base class of code
    class CodeBase
      include Validators

      def initialize(full_sounds)
        @rotation_hash = YAML.load_file(Helper.config_path("rotation.yml"))
        @degrees_hash = YAML.load_file(Helper.config_path("degrees.yml"))
        @full_harmonies = full_harmonies(full_sounds)
      end

      def full_harmonies(full_sounds)
        full_sounds.transpose.map{ |harmony| harmony.sort }
      end

      # get degree from bass
      #
      # @param [Integer] sound sound as number
      # @param [Integer] bass bass sound as number
      # @return [Integer] degree
      def degree_from_bass(sound, bass)
        degrees_hash[(sound - bass) % 12]
      end

      # get bass number by harmony
      #
      # @param [Array] harmony
      # @return [Integer] bass sound as number
      def bass(harmony)
        harmony[0]
      end

      # accessor to @@degrees_hash
      #
      # @return [Hash] degrees hash
      def degrees_hash
        @degrees_hash
      end

      # accessor to @@rotation_hash
      #
      # @return [Hash] rotation hash
      def rotation_hash
        @rotation_hash
      end

    end

  end

end
