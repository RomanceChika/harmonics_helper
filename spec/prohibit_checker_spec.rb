RSpec.describe HarmonicsHelper::ProhibitCheckerModule do

  BAD_TENOR_SOUNDS = [45, 45, 45, 47, 48, 48, 48, 45, 43, 45]
  BAD_TENOR_DURATIONS = [1, 1, 1, 1, 1, 1, 2, 1, 3, 3]
  BAD_BASS_SOUNDS = [29, 33, 38, 35, 36, 29, 36, 38, 36, 29]
  BAD_BASS_DURATIONS = [1, 1, 1, 1, 1, 1, 2, 1, 3, 3]

  GOOD_SOPRANO_SOUNDS = [64, 65, 64, 62, 60, 65, 62, 60]
  GOOD_SOPRANO_DURATIONS = [2, 2, 2, 2, 2, 2, 4, 4]
  GOOD_BASS_SOUNDS = [36, 41, 36, 43, 45, 41, 43, 36]
  GOOD_BASS_DURATIONS = [2, 2, 2, 2, 2, 2, 4, 4]

  GOOD_PROGRESSIONS = {0=>{"sound"=>28, "progress"=>0, "direction"=>true}, 1=>{"sound"=>24, "progress"=>-4, "direction"=>true}, 2=>{"sound"=>28, "progress"=>4, "direction"=>false}, 3=>{"sound"=>19, "progress"=>-9, "direction"=>true}, 4=>{"sound"=>15, "progress"=>-4, "direction"=>true}, 5=>{"sound"=>24, "progress"=>9, "direction"=>false}, 6=>{"sound"=>19, "progress"=>-5, "direction"=>true}, 7=>{"sound"=>24, "progress"=>5, "direction"=>false}}
  BAD_PROGRESSIONS = {0=>{"sound"=>16, "progress"=>0, "direction"=>true}, 1=>{"sound"=>12, "progress"=>-4, "direction"=>true}, 2=>{"sound"=>7, "progress"=>-5, "direction"=>true}, 3=>{"sound"=>12, "progress"=>5, "direction"=>false}, 4=>{"sound"=>12, "progress"=>0, "direction"=>true}, 5=>{"sound"=>19, "progress"=>7, "direction"=>false}, 6=>{"sound"=>12, "progress"=>-7, "direction"=>true}, 7=>{"sound"=>7, "progress"=>-5, "direction"=>true}, 8=>{"sound"=>7, "progress"=>0, "direction"=>true}, 9=>{"sound"=>16, "progress"=>9, "direction"=>false}}

  let(:test_object) { Object.new.extend(HarmonicsHelper::ProhibitCheckerModule) }
  let(:bad_pair_parts) { HarmonicsHelper::PairParts(BAD_TENOR_SOUNDS, BAD_TENOR_DURATIONS, BAD_BASS_SOUNDS, BAD_BASS_DURATIONS) }
  let(:good_pair_parts) { HarmonicsHelper::PairParts(GOOD_SOPRANO_DURATIONS, GOOD_SOPRANO_DURATIONS, GOOD_BASS_SOUNDS, GOOD_BASS_DURATIONS)}
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

      it "bad sample intervals 5 th sound has prohibit" do
        expect(test_object.conencutive_prohibit(BAD_PROGRESSIONS)[4]).to eq(true)
      end
    end
  end


end