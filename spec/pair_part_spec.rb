RSpec.describe HarmonicsHelper::PairParts do

  # These numbers comes from soprano and bass parts of MusicXMLSample
  SOPRANO_SOUNDS = [64, 65, 64, 62, 60, 65, 62, 60]
  SOPRANO_DURATION = [2, 2, 2, 2, 2, 2, 4, 4]
  BASS_SOUNDS = [36, 41, 36, 43, 45, 41, 43, 36] 
  BASS_DURATION = [2, 2, 2, 2, 2, 2, 4, 4]
  let(:pair_parts) { HarmonicsHelper::PairParts.new(SOPRANO_SOUNDS, SOPRANO_DURATION, BASS_SOUNDS, BASS_DURATION)}

  describe "#initialize" do
    context "raise exception" do
      it "if all length is different raise Error" do
        expect{ HarmonicsHelper::PairParts.new(SOPRANO_SOUNDS, SOPRANO_DURATION, BASS_SOUNDS, [2, 2, 2, 2, 2, 2, 2, 2]) }.to raise_error(StandardError)
      end

      it "if base args length is different raise Error" do
        expect{ HarmonicsHelper::PairParts.new(SOPRANO_SOUNDS, SOPRANO_DURATION, BASS_SOUNDS, [2, 2, 2, 2, 2, 2, 2]) }.to raise_error(StandardError)
      end

      it "if soprano args length is different raise Error" do
        expect{ HarmonicsHelper::PairParts.new(SOPRANO_SOUNDS, [2, 2, 2, 2, 2, 2], BASS_SOUNDS, BASS_DURATION) }.to raise_error(StandardError)
      end

    end
  end

  describe "#full_intervals" do
    it "sample full intervals are start with 28" do
      expect(pair_parts.full_intervals).to start_with 28 
    end
    it "sample full intervals length is 20" do
      expect(pair_parts.full_intervals.length).to eq(20)
    end

    it "sample full intervals are end with 24" do
      expect(pair_parts.full_intervals).to end_with 24
    end
  end
  
  describe "#full_interval_progression" do
    it "sample full interval progression is start with 0" do
      expect(pair_parts.full_interval_progression).to start_with 0
    end

    it "sample full interval progression first change is 4" do
      expect(pair_parts.full_interval_progression).to start_with 0
    end


    it "sample full interval progression length is 19" do
      expect(pair_parts.full_interval_progression.length).to eq(19)
    end

    it "sample full interval progression is end with -2" do
      expect(pair_parts.full_interval_progression).to end_with 0
    end
  end

end