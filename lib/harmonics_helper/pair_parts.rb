require "matrix"
require "harmonics_helper/part"

module HarmonicsHelper
  
  # class deal with pair of parts
  class PairParts
    include PartModule 

    def initialize(sounds1, durations1, sounds2, durations2)
      durations_validator(sounds1, durations1)
      durations_validator(sounds2, durations2)
      @full_sounds1 = full_sounds_base(sounds1, durations1)
      @full_sounds2 = full_sounds_base(sounds2, durations2)
      @sounds1 = sounds1
      @sounds2 = sounds2
      @full_sounds_hash1 = full_sounds_hash_base(sounds1, durations1)
      @full_sounds_hash2 = full_sounds_hash_base(sounds2, durations2)
      length_validator
      @length = common_length
    end

    # get full duration intervals of pair parts
    # 
    # @return [Array] intervals as numbers array
    def full_intervals()
      @length.times.map{ |index| @full_sounds1[index] - @full_sounds2[index] }
    end

    # get full sounds hash has sound and order
    # able to specify sounds1 and sound2
    #
    # @param [Integer] whitch full sounds hash use
    # @return [Array] each elements is hash has sound and order
    def full_sounds_hash(num)
      (num==1)? @full_sounds_hash1 : @full_sounds_hash2
    end

    # get full interval progression of pair parts
    #
    # @return [Array] interval progression as numbers array
    def full_interval_progression()
      progression_base(full_intervals)
    end

    # get intervals of pair parts
    # TODO: should implement if different duration
    #
    # @return [Array] interval as numbers array
    def intervals()
      (Vector.elements(@sounds1) - Vector.elements(@sounds2)).to_a
    end

    # get intervals progression of pair parts
    # TODO: should implement if different duration
    #
    # @return [Array] interval progression as numbers array
    def intervals_progression()
      progression_base(intervals)
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