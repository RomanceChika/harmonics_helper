RSpec.describe HarmonicsHelper::Parser do

  let(:parser) { HarmonicsHelper::Parser.new("MusicXMLSample.xml") }

  describe "#initialize" do
    it "document not to be nill" do
      expect(parser.document).not_to be nil
    end
  end

  describe "#parts" do
    it "sample parts is [1,2,5,6]" do
      expect(parser.parts).to eq([1,2,5,6])
    end
  end

  describe "#sounds" do
    # sample soprano is 1 and bass is 6
    it "sample soprano start with 5E" do
      # 5E is 12*5 + 4 = 64
      expect(parser.sounds(1)).to start_with 64
    end

    it "sample soprano length is 8" do
      expect(parser.sounds(1).length).to eq(8)
    end

    it "sample soprano length equal sample bass length" do
      expect(parser.sounds(1).length).to eq(parser.sounds(6).length)
    end

    it "sample soprano is end with 5C" do
      # 5C is 12*5 + 0 = 60
      expect(parser.sounds(1)).to end_with 60 
    end
  end

  describe "#beat" do
    it "sample beat is 4" do
      expect(parser.beat).to eq(4)
    end
  end

  describe "#beat_type" do
    it "sample beat types is 4" do
      expect(parser.beat_type).to eq(4)
    end
  end

  describe "#durations" do
    it "sample soprano durations length is 8" do
      expect(parser.durations(1).length).to eq(8)
    end

    it "sample soprano durations[2,2,2,2,2,2,4,4]" do
      expect(parser.durations(1)).to eq([2,2,2,2,2,2,4,4])
    end
  end

end