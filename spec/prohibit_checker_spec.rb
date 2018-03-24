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

RSpec.describe HarmonicsHelper::ProhibitCheckerModule do

  GOOD_PAIRS = [{0=>{"sound"=>55, "progress"=>0}, 1=>{"sound"=>57, "progress"=>2}, 2=>{"sound"=>55, "progress"=>-2}, 3=>{"sound"=>55, "progress"=>0}, 4=>{"sound"=>52, "progress"=>-3}, 5=>{"sound"=>57, "progress"=>5}, 6=>{"sound"=>55, "progress"=>-2}, 7=>{"sound"=>52, "progress"=>-3}}, {0=>{"sound"=>64, "progress"=>0}, 1=>{"sound"=>65, "progress"=>1}, 2=>{"sound"=>64, "progress"=>-1}, 3=>{"sound"=>62, "progress"=>-2}, 4=>{"sound"=>60,"progress"=>-2}, 5=>{"sound"=>65, "progress"=>5}, 6=>{"sound"=>62, "progress"=>-3}, 7=>{"sound"=>60, "progress"=>-2}}]
  BAD_PAIRS = [{0=>{"sound"=>29, "progress"=>0}, 1=>{"sound"=>33, "progress"=>4}, 2=>{"sound"=>38, "progress"=>5}, 3=>{"sound"=>35, "progress"=>-3}, 4=>{"sound"=>36, "progress"=>1}, 5=>{"sound"=>29, "progress"=>-7}, 6=>{"sound"=>36, "progress"=>7}, 7=>{"sound"=>38, "progress"=>2}, 8=>{"sound"=>36, "progress"=>-2}, 9=>{"sound"=>29, "progress"=>-7}}, {0=>{"sound"=>45, "progress"=>0}, 1=>{"sound"=>45, "progress"=>0}, 2=>{"sound"=>45, "progress"=>0}, 3=>{"sound"=>47, "progress"=>2}, 4=>{"sound"=>48, "progress"=>1}, 5=>{"sound"=>48, "progress"=>0}, 6=>{"sound"=>48, "progress"=>0}, 7=>{"sound"=>45, "progress"=>-3}, 8=>{"sound"=>43, "progress"=>-2}, 9=>{"sound"=>45, "progress"=>2}}]

  let(:test_object) { Object.new.extend(HarmonicsHelper::ProhibitCheckerModule) }
  describe "#code?" do
    context "resolvable" do
      it "basic resolvable to code" do
        expect(test_object.code?("basic")).to eq(true)
      end
    end
    context "unresolvable" do
      it "empty code is false" do
        expect(test_object.code?("")).to eq(false)
      end
    end
  end

  describe "#consecutive_prohibit" do
    context "exception_occured" do
      it "is pairs length is not 2 raise error" do
        expect { test_object.consecutive_prohibit([1]) }.to raise_error(HarmonicsHelper::Errors::LengthError)
      end
      it "is pairs length is different raise error" do
        expect { test_object.consecutive_prohibit([[1], [1, 2]]) }.to raise_error(HarmonicsHelper::Errors::LengthError)
      end
    end
    context "has not consecutive prohibit" do
      it "good sample intervals has not consecutive prohibit" do
        expect(test_object.consecutive_prohibit(GOOD_PAIRS).any?).to eq(false)
      end
    end

    context "has consecutive prohibit" do
      it "bad sample intervals has prohibit" do
        expect(test_object.consecutive_prohibit(BAD_PAIRS).any?).to eq(true)
      end

      it "bad sample intervals 5th sound has prohibit" do
        expect(test_object.consecutive_prohibit(BAD_PAIRS).any?).to eq(true)
      end
    end
  end

end

RSpec.describe HarmonicsHelper::ProhibitChecker do

  # B means BAD_
  bsoprano_durations = [1, 1, 1, 1, 1, 1, 2, 1, 3, 3]
  balt_durations = [1, 1, 1, 1, 1, 1, 2, 1, 3, 3]
  btenor_durations = [1, 1, 1, 1, 1, 1, 2, 1, 3, 3]
  bbass_durations = [1, 1, 1, 1, 1, 1, 2, 1, 3, 3]
  bsoprano_sounds = [60, 60, 60, 62, 64, 65, 64, 62, 60, 60]
  balt_sounds = [53, 52, 53, 53, 55, 57, 55, 53, 55, 53]
  btenor_sounds = [45, 45, 45, 47, 48, 48, 48, 45, 43, 45]
  bbass_sounds = [29, 33, 38, 35, 36, 29, 36, 38, 36, 29]
  bbeat = 3
  bbeat_type = 4
  before do
    @good_parser_mock = double("parser mock")
    @bad_parser_mock = double("parserbad mock")
    allow(@good_parser_mock).to receive(:beat).and_return(beat)
    allow(@good_parser_mock).to receive(:beat_type).and_return(beat_type)
    allow(@good_parser_mock).to receive(:sounds).with(1).and_return(soprano_sounds)
    allow(@good_parser_mock).to receive(:sounds).with(2).and_return(alt_sounds)
    allow(@good_parser_mock).to receive(:sounds).with(5).and_return(tenor_sounds)
    allow(@good_parser_mock).to receive(:sounds).with(6).and_return(bass_sounds)
    allow(@good_parser_mock).to receive(:durations).with(1).and_return(soprano_durations)
    allow(@good_parser_mock).to receive(:durations).with(2).and_return(alt_durations)
    allow(@good_parser_mock).to receive(:durations).with(5).and_return(tenor_durations)
    allow(@good_parser_mock).to receive(:durations).with(6).and_return(bass_durations)
    allow(@good_parser_mock).to receive(:parts).and_return(parts)

    allow(@bad_parser_mock).to receive(:beat).and_return(bbeat)
    allow(@bad_parser_mock).to receive(:beat_type).and_return(bbeat_type)
    allow(@bad_parser_mock).to receive(:sounds).with(1).and_return(bsoprano_sounds)
    allow(@bad_parser_mock).to receive(:sounds).with(2).and_return(balt_sounds)
    allow(@bad_parser_mock).to receive(:sounds).with(5).and_return(btenor_sounds)
    allow(@bad_parser_mock).to receive(:sounds).with(6).and_return(bbass_sounds)
    allow(@bad_parser_mock).to receive(:durations).with(1).and_return(bsoprano_durations)
    allow(@bad_parser_mock).to receive(:durations).with(2).and_return(balt_durations)
    allow(@bad_parser_mock).to receive(:durations).with(5).and_return(btenor_durations)
    allow(@bad_parser_mock).to receive(:durations).with(6).and_return(bbass_durations)
    allow(@bad_parser_mock).to receive(:parts).and_return(parts)
  end
  let(:good_prohibit_checker) { HarmonicsHelper::ProhibitChecker.new(@good_parser_mock) }
  let(:bad_prohibit_checker) { HarmonicsHelper::ProhibitChecker.new(@bad_parser_mock) }

  describe "#consecutive_prohibits_all" do
    context "bad sample has prohibit" do
      it "bad sample has concenctive_prohibit" do
        expect(bad_prohibit_checker.consecutive_prohibits_all.flatten.any?).to eq(true)
      end
    end
    context "good sample has no prohibit" do
      it "good sample has no concenctive prohibit all" do
        expect(good_prohibit_checker.consecutive_prohibits_all.flatten.any?).to eq(false)
      end
    end
  end
    
  describe "#code_configured_all" do
    context "bad sample has code configured prohibit" do
      it "bad sample has non 3rd prohibit" do
        expect(bad_prohibit_checker.code_configured_all.all?).to eq(false)
      end
    end
    context "good sample has no prohibit" do
      it "good sample configured all code" do
        expect(good_prohibit_checker.code_configured_all.all?).to eq(true)
      end
    end
  end

end