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

RSpec.describe HarmonicsHelper::Part::SinglePart do

  # These numbers comes from soprano parts of MusicXMLSample
  let(:single_part) { HarmonicsHelper::Part::SinglePart.new(soprano_sounds, soprano_durations)}

  describe "#initialize" do
    context "raise exception" do
      it "if soprano args length is different raise Error" do
        expect{ HarmonicsHelper::Part::SinglePart.new(soprano_sounds, [2, 2, 2, 2, 2, 2]) }.to raise_error(HarmonicsHelper::Errors::LengthError)
      end
    end
  end

  describe "#full_sounds" do
    it "sample full sounds are start with 64" do
      expect(single_part.full_sounds).to start_with 64
    end

    it "sample full sounds length is 20" do
      expect(single_part.full_sounds.length).to eq(20)
    end

    it "sample full sounds are end with 60" do
      expect(single_part.full_sounds).to end_with 60
    end
  end
  
  describe "#progression" do
    it "sample progression is start with 0" do
      expect(single_part.progression[0]["progress"]).to eq(0)
    end

    it "sample progression length is 8" do
      expect(single_part.progression.length).to eq(8)
    end

    it "sample progression is end with -2" do
      expect(single_part.progression[7]["progress"]).to eq(-2)
    end
  end

  describe "#full_progression" do
    it "sample full progression is start with 0" do
      expect(single_part.full_progression[0]["progress"]).to start_with 0
    end

    it "sample full progression length is 20" do
      expect(single_part.full_progression.length).to eq(20)
    end

    it "sample full progression is end with 0" do
      expect(single_part.full_progression[19]["progress"]).to eq(0)
    end
  end

end