RSpec.describe HarmonicsHelper::ProhibitFormatter do
  let(:bad_xml) { open(File.join(File.dirname(__FILE__), '../files/' + "BadSample.xml")) }
  let(:good_xml) { open(File.join(File.dirname(__FILE__), '../files/' + "GoodSample.xml")) }
  let(:bad_formatter) { HarmonicsHelper::ProhibitFormatter.new(bad_xml) }
  let(:good_formatter) { HarmonicsHelper::ProhibitFormatter.new(good_xml) }

  describe "#has_consecutive_prohibit?" do
    it "bad sample has prohibit" do
      expect(bad_formatter.has_consecutive_prohibit?).to eq(true)
    end
    it "good sample has no prohibit" do
      expect(good_formatter.has_consecutive_prohibit?).to eq(false)
    end
  end

  describe "#has_code_prohibit?" do
    it "bad sample has prohibit" do
      expect(bad_formatter.has_code_prohibit?).to eq(true)
    end
    it "good sample has no prohibit" do
      expect(good_formatter.has_code_prohibit?).to eq(false)
    end
  end

  describe "#has_any_prohibit?" do
    it "bad sample has prohibit" do
      expect(bad_formatter.has_any_prohibit?).to eq(true)
    end
    it "good sample has no prohibit" do
      expect(good_formatter.has_any_prohibit?).to eq(false)
    end
  end

  describe "#prohibit_message" do
    it "prohibit message has [Failure]" do
      expect(good_formatter.prohibit_message(true).include?("Failure")).to eq(true)
    end
    it "no prohibit message has [Success]" do
      expect(good_formatter.prohibit_message(false).include?("Success")).to eq(true)
    end
  end

  describe "#measure_slicer" do
    it "good sample measure slicer is 4" do
      expect(good_formatter.measure_slicer).to eq(4)
    end
  end

end