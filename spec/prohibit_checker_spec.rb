RSpec.describe HarmonicsHelper::ProhibitCheckerModule do

  GOOD_PROGRESSIONS = {0=>{"sound"=>28, "progress"=>0, "direction"=>true}, 1=>{"sound"=>24, "progress"=>-4, "direction"=>true}, 2=>{"sound"=>28, "progress"=>4, "direction"=>false}, 3=>{"sound"=>19, "progress"=>-9, "direction"=>true}, 4=>{"sound"=>15, "progress"=>-4, "direction"=>true}, 5=>{"sound"=>24, "progress"=>9, "direction"=>false}, 6=>{"sound"=>19, "progress"=>-5, "direction"=>true}, 7=>{"sound"=>24, "progress"=>5, "direction"=>false}}
  BAD_PROGRESSIONS = {0=>{"sound"=>16, "progress"=>0, "direction"=>true}, 1=>{"sound"=>12, "progress"=>-4, "direction"=>true}, 2=>{"sound"=>7, "progress"=>-5, "direction"=>true}, 3=>{"sound"=>12, "progress"=>5, "direction"=>false}, 4=>{"sound"=>12, "progress"=>0, "direction"=>true}, 5=>{"sound"=>19, "progress"=>7, "direction"=>false}, 6=>{"sound"=>12, "progress"=>-7, "direction"=>true}, 7=>{"sound"=>7, "progress"=>-5, "direction"=>true}, 8=>{"sound"=>7, "progress"=>0, "direction"=>true}, 9=>{"sound"=>16, "progress"=>9, "direction"=>false}}

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

  describe "#conencutive_prohibit" do
    context "has not concencutive prohibit" do
      it "good sample intervals has not concencutive prohibit" do
        expect(test_object.conencutive_prohibit(GOOD_PROGRESSIONS).any?).to eq(false)
      end
    end

    context "has concencutive prohibit" do
      it "bad sample intervals has prohibit" do
        expect(test_object.conencutive_prohibit(BAD_PROGRESSIONS).all?).to eq(false)
      end

      it "bad sample intervals 5th sound has prohibit" do
        expect(test_object.conencutive_prohibit(BAD_PROGRESSIONS)[4]).to eq(true)
      end
    end
  end

end

RSpec.describe HarmonicsHelper::ProhibitChecker do

  let(:good_parser) { HarmonicsHelper::Parser.new("GoodSample.xml") }
  let(:good_prohibit_checker) { HarmonicsHelper::ProhibitChecker.new(good_parser) }
  let(:bad_parser) { HarmonicsHelper::Parser.new("BadSample.xml") }
  let(:bad_prohibit_checker) { HarmonicsHelper::ProhibitChecker.new(bad_parser) }

=begin
  describe "#prohibit?" do
    context "bad sample has prohibit" do
      it "bas sample has prohibit" do
        expect(bad_prohibit_checker.prohibit?).to eq(true)
      end
    end
    context "good sample has not prohibit" do
      it "good sample has no prohibit" do
        expect(good_prohibit_checker.prohibit?).to eq(false)
      end
    end
  end
=end

  describe "#conencutive_prohibits_all" do
    context "bad sample has prohibit" do
      it "bad sample has concenctive_prohibit" do
        expect(bad_prohibit_checker.concencutive_prohibits_all.flatten.any?).to eq(true)
      end
    end
    context "good sample has no prohibit" do
      it "good sample has no concenctive prohibit all" do
        expect(good_prohibit_checker.concencutive_prohibits_all.flatten.any?).to eq(false)
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