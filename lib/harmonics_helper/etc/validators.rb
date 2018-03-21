require "harmonics_helper/etc/exceptions"

module HarmonicsHelper
  
  module Validators

    # if sounds and durations is different size, raise Error
    def durations_validator(sounds, durations)
      if sounds.length != durations.length then
        raise HarmonicsHelper::Errors::LengthError.new("sounds length is different from durations length")
      end
    end

    # if part length is not 4 raise error
    #
    # @param [Array] parts
    def four_parts_validation(parts)
      if parts.length != 4 then
        raise HarmonicsHelper::Errors::FourPartsError.new("Not Fout Tone")
      end
    end

    # if each parts durations is different, raise error
    #  should implement different duration 
    # 
    # @params[Array] all_durations
    def four_parts_duration_validation(common_duration)
      if common_duration.length != 1
        raise HarmonicsHelper::Errors::DurationUnmatchError.new("Durations are different")
      end
    end

    # if each length is different, raise exception
    def length_validator()
      if @full_sounds1.length != @full_sounds2.length then
        raise HarmonicsHelper::Errors::LengthError.new("length of each sound is different")
      end
    end

    # check array size
    def array_size_validator(array, size)
      if array.length != size
        raise HarmonicsHelper::Errors::LengthError.new("invalid input array length")
      end
    end
    
    # check same length of array
    def same_length_validator(array1, array2)
      if array1.length != array2.length
        raise HarmonicsHelper::Errors::LengthError.new("length of each array is different") 
      end
    end

  end

end

