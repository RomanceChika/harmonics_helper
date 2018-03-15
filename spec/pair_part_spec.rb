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

  describe "#full_sounds_hash" do
    it "sample full sounds hash sound is start with 64" do
      expect(pair_parts.full_sounds_hash(1).first["sound"]).to eq(64)
    end

    it "sample full sounds hash bass sound is start with 36" do
      expect(pair_parts.full_sounds_hash(2).first["sound"]).to eq(36)
    end


    it "sample full sounds hash order is start with 1" do
      expect(pair_parts.full_sounds_hash(1).first["order"]).to eq(1) 
    end

    it "sample full sounds hash length is 20" do
      expect(pair_parts.full_sounds_hash(1).length).to eq(20)
    end

  
    it "sample full sounds hash sound is end with 60" do
      expect(pair_parts.full_sounds_hash(1).last["sound"]).to eq(60)
    end

    it "sample full sounds hash order is end with 8" do
      expect(pair_parts.full_sounds_hash(1).last["order"]).to eq(8) 
    end

  end

  describe "#intervals" do
    it "sample intervals are start with 28" do
      expect(pair_parts.intervals).to start_with 28
    end

    it "sample intervals length are 8" do
      expect(pair_parts.intervals.length).to eq(8)
    end
  
    it "sample intervals are end with 24" do
      expect(pair_parts.intervals).to end_with 24
    end
  end

  describe "#full_interval_progression" do
    it "sample full interval progression is start with 0" do
      expect(pair_parts.full_interval_progression).to start_with 0
    end

    it "sample full interval progression first change is 4" do
      expect(pair_parts.full_interval_progression).to start_with 0
    end


    it "sample full interval progression length is 20" do
      expect(pair_parts.full_interval_progression.length).to eq(20)
    end

    it "sample full interval progression is end with 0" do
      expect(pair_parts.full_interval_progression).to end_with 0
    end
  end

  describe "#interval_progression" do
    it "sample interval progression is start with 0" do
      expect(pair_parts.intervals_progression).to start_with 0 
    end

    it "sample interval progression length is 8" do
      expect(pair_parts.intervals_progression.length).to eq(8)
    end

    it "sample interval progression is end with 5" do
      expect(pair_parts.intervals_progression).to end_with 5 
    end
  end

end