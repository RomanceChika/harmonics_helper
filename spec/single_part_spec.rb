RSpec.describe HarmonicsHelper::SinglePart do

  # These numbers comes from soprano parts of MusicXMLSample
  let(:single_part) { HarmonicsHelper::SinglePart.new([64, 65, 64, 62, 60, 65, 62, 60])}
  let(:durations) { [2, 2, 2, 2, 2, 2, 4, 4]}

  describe "#full_sounds" do
    it "sample full sounds are start with 64" do
      expect(single_part.full_sounds(durations)).to start_with 64
    end

    it "sample full sounds length is 20" do
      expect(single_part.full_sounds(durations).length).to eq(20)
    end

    it "sample full sounds are end with 60" do
      expect(single_part.full_sounds(durations)).to end_with 60
    end
  end
  
  describe "#progression" do
    it "sample progression is start with 1" do
      expect(single_part.progression).to start_with 1
    end

    it "sample progression length is 7" do
      expect(single_part.progression.length).to eq(7)
    end

    it "sample progression is end with -2" do
      expect(single_part.progression).to end_with -2
    end
  end

  describe "#full_progression" do
    it "sample full progression is start with 0" do
      expect(single_part.full_progression(durations)).to start_with 0
    end

    it "sample full progression length is 19" do
      expect(single_part.full_progression(durations).length).to eq(19)
    end

    it "sample full progression is end with -2" do
      expect(single_part.full_progression(durations)).to end_with 0
    end
  end

end