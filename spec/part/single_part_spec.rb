RSpec.describe HarmonicsHelper::Part::SinglePart do

  # These numbers comes from soprano parts of MusicXMLSample
  SOPRANO_SOUNDS = [64, 65, 64, 62, 60, 65, 62, 60]
  SOPRANO_DURATION = [2, 2, 2, 2, 2, 2, 4, 4]
  let(:single_part) { HarmonicsHelper::Part::SinglePart.new(SOPRANO_SOUNDS, SOPRANO_DURATION)}

  describe "#initialize" do
    context "raise exception" do
      it "if soprano args length is different raise Error" do
        expect{ HarmonicsHelper::Part::SinglePart.new(SOPRANO_SOUNDS, [2, 2, 2, 2, 2, 2]) }.to raise_error(HarmonicsHelper::Errors::LengthError)
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