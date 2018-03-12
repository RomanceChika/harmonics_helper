require "matrix"
# These numbers comes from MusicXMLSample
SOPRANO_SOUNDS = [64, 65, 64, 62, 60, 65, 62, 60]
ALT_SOUNDS = [55, 57, 55, 59, 60, 57, 55, 52]
TENOR_SOUNDS = [48, 48, 48, 50, 48, 48, 47, 48]
BASS_SOUNDS = [36, 41, 36, 43, 45, 41, 43, 36] 

FULL_SOUNDS = [SOPRANO_SOUNDS, ALT_SOUNDS, TENOR_SOUNDS, BASS_SOUNDS]

RSpec.describe HarmonicsHelper::Code::Rotations do

  let(:rotations) { HarmonicsHelper::Code::Rotations.new(FULL_SOUNDS)}
  
  describe "#initialize" do
    context "raise exception" do
      it "if all length is different raise Error" do
        expect{ HarmonicsHelper::Code::Rotations.new([2, 2], [2, 2, 2, 2, 2, 2, 2, 2]) }.to raise_error(StandardError)
      end
    end
  end

  describe "rotation_types" do
    context "case decide rotation type" do
      it "sample rotation at first is basic" do
        expect(rotations.rotation_types).to start_with "basic"
      end
    end
    context "case undefined rotation type" do
      it "bad sample first rotation at first is empty" do
        # has not 3rd tone E
        bad_soprano_sounds = [60, 65, 64, 62, 60, 65, 62, 60]
        bad_full_sounds = [bad_soprano_sounds, ALT_SOUNDS, TENOR_SOUNDS, BASS_SOUNDS]
        bad_rotations = HarmonicsHelper::Code::Rotations.new(bad_full_sounds)
        expect(bad_rotations.rotation_types).to start_with ""
      end
    end

  end

=begin
  describe "#initialize" do
    context "raise exception" do
      it "if all length is different raise Error" do
        expect{ HarmonicsHelper::Code::AllParts.new([2, 2], [2, 2, 2, 2, 2, 2, 2, 2]) }.to raise_error(StandardError)
      end
    end
=end

  end
