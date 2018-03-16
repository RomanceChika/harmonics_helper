module HarmonicsHelper

  # full length is unmatch
  class DurationUnmatchError < StandardError

    def initialize(error_code, message)
      @code = error_code
      super("[#{error_code} - #{message}")
    end

  end

  # parts length contains unmatch
  class PartsLengthError < StandardError

    def initialize(error_code, message)
      @code = error_code
      super("[#{error_code} - #{message}")
    end

  end


end