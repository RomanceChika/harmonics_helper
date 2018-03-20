require "matrix"
# These numbers comes from MusicXMLSample
soprano = [64, 65, 64, 62, 60, 65, 62, 60]
alt = [55, 57, 55, 59, 60, 57, 55, 52]
tenor = [48, 48, 48, 50, 48, 48, 47, 48]
bass = [36, 41, 36, 43, 45, 41, 43, 36] 

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

full_sounds = [soprano, alt, tenor, bass]

RSpec.describe HarmonicsHelper::Code::Rotations do

  let(:rotations) { HarmonicsHelper::Code::Rotations.new(full_sounds)}
  
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
        bad_full_sounds = [bad_soprano_sounds, alt_sounds, tenor_sounds, bass_sounds]
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
