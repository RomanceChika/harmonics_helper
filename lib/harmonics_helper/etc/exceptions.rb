module HarmonicsHelper

  module Errors

    # length has unmatch
    class LengthError < StandardError

      def initialize(message)
        @code = 51
        super("[#{@code} - #{message}")
      end

    end

    # parts length contains unmatch
    class PartsLengthError < StandardError

      def initialize(error_code, message)
        @code = error_code
        super("[#{error_code} - #{message}")
      end

    end

    class FourPartsError < StandardError

      def initialize(message)
        @code = 50
        super("[#{@code} - #{message}")
      end
    end

    # Duration is different 
    class DurationUnmatchError < StandardError

      def initialize(message)
        @code = 51
        super("[#{@code} - #{message}")
      end

    end

    # error about file path
    class FilePathError < StandardError

      def initialize(message)
        @code = 30
        super("[#{@code} - #{message}")
      end
    end

  end

end