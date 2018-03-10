require "harmonics_helper/part_base"

module HarmonicsHelper
  
  # class deal with pair of parts
  class PairParts < PartBase

    def initialize(sounds1, durations1, sounds2, durations2)
      durations_validator(sounds1, durations1)
      durations_validator(sounds2, durations2)
      @full_sounds1 = full_sounds_base(sounds1, durations1)
      @full_sounds2 = full_sounds_base(sounds2, durations2)
      length_validator
      @length = common_length
    end

    # get full duration intervals of pair parts
    # 
    # @return [Array] intervals as numbers array
    def full_intervals()
      @length.times.map{ |index| @full_sounds1[index] - @full_sounds2[index] }
    end

    # get full interval progression of pair parts
    #
    # @return [Array] interval progression as numbers array
    def full_interval_progression()
      progression_common(full_intervals)
    end

    private
    # get common length
    #
    # @return [Integer] common length
    def common_length()
      @full_sounds1.length
    end

    # if each length is different, raise exception
    def length_validator()
      if @full_sounds1.length != @full_sounds2.length then
        raise DurationUnmatchException(30, "length of each sound is different")
      end
    end

  end

end