parts = [1, 2, 5, 6]
soprano_durations = [2, 2, 2, 2, 2, 2, 4, 4]
alt_durations = [2, 2, 2, 2, 2, 2, 4, 4]
tenor_durations = [2, 2, 2, 2, 2, 2, 4, 4]
bass_durations = [2, 2, 2, 2, 2, 2, 4, 4]
soprano_sounds = [64, 65, 64, 62, 60, 65, 62, 60]
alt_sounds = [55, 57, 55, 55, 52, 57, 55, 52]
tenor_sounds = [48, 48, 48, 47, 48, 48, 47, 48]
bass_sounds = [36, 41, 36, 43, 45, 41, 43, 36]
beat = 4
beat_type = 4

RSpec.describe HarmonicsHelper::Part::PairParts do

  # These numbers comes from soprano and bass parts of MusicXMLSample
  let(:pair_parts) { HarmonicsHelper::Part::PairParts.new(soprano_sounds, soprano_durations, bass_sounds, bass_durations)}

  describe "#initialize" do
    context "raise exception" do
      it "if all length is different raise Error" do
        expect{ HarmonicsHelper::Part::PairParts.new(soprano_sounds, soprano_durations, bass_sounds, [2, 2, 2, 2, 2, 2, 2, 2]) }.to raise_error(HarmonicsHelper::Errors::LengthError)
      end

      it "if base args length is different raise Error" do
        expect{ HarmonicsHelper::Part::PairParts.new(soprano_sounds, soprano_durations, bass_sounds, [2, 2, 2, 2, 2, 2, 2]) }.to raise_error(HarmonicsHelper::Errors::LengthError)
      end

      it "if soprano args length is different raise Error" do
        expect{ HarmonicsHelper::Part::PairParts.new(soprano_sounds, [2, 2, 2, 2, 2, 2], bass_sounds, bass_durations) }.to raise_error(HarmonicsHelper::Errors::LengthError)
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
      expect(pair_parts.full_interval_progression[0]["progress"]).to eq(0)
    end

    it "sample full interval progression first change is -4" do
      expect(pair_parts.full_interval_progression[2]["progress"]).to eq(-4)
    end

    it "sample full interval progression length is 20" do
      expect(pair_parts.full_interval_progression.length).to eq(20)
    end

    it "sample full interval progression is end with 0" do
      expect(pair_parts.full_interval_progression[19]["progress"]).to eq(0)
    end
  end

  describe "#interval_progression" do
    it "sample interval progression is start with 0" do
      expect(pair_parts.intervals_progression[0]["progress"]).to eq(0) 
    end

    it "sample interval progression length is 8" do
      expect(pair_parts.intervals_progression.length).to eq(8)
    end

    it "sample interval progression is end with 5" do
      expect(pair_parts.intervals_progression[7]["progress"]).to eq(5) 
    end
  end

end