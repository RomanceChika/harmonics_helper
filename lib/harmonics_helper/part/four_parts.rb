require "harmonics_helper/part/part"
require "harmonics_helper/xml_parser"
require "harmonics_helper/etc/validators"

module HarmonicsHelper

  module Part

    # Four Tone Parts
    class FourParts
      include PartModule
      include Validators

      def initialize(parser)
        @parts = initialize_parts(parser)
        @common_duration = initialize_common_duration(parser)
        @four_parts = initialize_four_parts(parser, @parts)
      end

      def dummy()
      end

      private
      def initialize_parts(parser)
        @parts = parser.parts
        # validate size
        four_parts_validation(@parts)
        @parts
      end

      def initialize_common_duration(parser)
        # TODO: if not common duration exist, shouldn't be error
        @common_duration = @parts.map { |part| parser.durations(part) }.uniq
        four_parts_duration_validation(@common_duration)
        @common_duration
      end

      def initialize_four_parts(parser, parts)
        @four_parts = parts.map { |part| parser.sounds(part) }.sort.map { |sounds| progression_base(sounds)}
      end

    end

  end

end