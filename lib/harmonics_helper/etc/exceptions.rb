module HarmonicsHelper

  module Errors

    # length is not matched
    class LengthError < StandardError

      def initialize(message)
        @code = 51
        super("[#{@code} - #{message}")
      end

    end

    # parts length is matched
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
    class DurationUnmatchedError < StandardError

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