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

RSpec.describe HarmonicsHelper::Part::FourParts do
  before do
    @parser_mock = double("Parser mock")
    @strange_parts_parsermock = double("parserbad mock")
    @strange_durations_parsermock = double("parserbad2 mock")
    allow(@parser_mock).to receive(:beat).and_return(beat)
    allow(@parser_mock).to receive(:beat_type).and_return(beat_type)
    allow(@parser_mock).to receive(:sounds).with(1).and_return(soprano_sounds)
    allow(@parser_mock).to receive(:sounds).with(2).and_return(alt_sounds)
    allow(@parser_mock).to receive(:sounds).with(5).and_return(tenor_sounds)
    allow(@parser_mock).to receive(:sounds).with(6).and_return(bass_sounds)
    allow(@parser_mock).to receive(:durations).with(1).and_return(soprano_durations)
    allow(@parser_mock).to receive(:durations).with(2).and_return(alt_durations)
    allow(@parser_mock).to receive(:durations).with(5).and_return(tenor_durations)
    allow(@parser_mock).to receive(:durations).with(6).and_return(bass_durations)
    allow(@parser_mock).to receive(:parts).and_return(parts)

    allow(@strange_parts_parsermock).to receive(:parts).and_return([1, 2])

    allow(@strange_durations_parsermock).to receive(:parts).and_return(parts)
    allow(@strange_durations_parsermock).to receive(:durations).with(1).and_return([2, 2, 2])
    allow(@strange_durations_parsermock).to receive(:durations).with(2).and_return(alt_durations)
    allow(@strange_durations_parsermock).to receive(:durations).with(5).and_return(tenor_durations)
    allow(@strange_durations_parsermock).to receive(:durations).with(6).and_return(bass_durations)
  end
  let(:four_parts) { HarmonicsHelper::Part::FourParts.new(@parser_mock) }

  describe "#initialize" do
    describe "fail to initialize bad parser" do
      it "if parts length is not 4 raise error" do
        expect { HarmonicsHelper::Part::FourParts.new(@strange_parts_parsermock) }.to raise_error(HarmonicsHelper::Errors::FourPartsError)
      end
      it "if parts duration is not common raise error" do
        expect { HarmonicsHelper::Part::FourParts.new(@strange_durations_parsermock) }.to raise_error(HarmonicsHelper::Errors::DurationUnmatchedError)
      end
    end
    describe "success to initialize good parser" do
      it "if parts length is 4 not raise error" do
        expect { HarmonicsHelper::Part::FourParts.new(@parser_mock)}.not_to raise_error(Exception)
      end
    end
  end

  describe "#all_pairs" do
    it "all pairs length is 6" do
      expect(four_parts.all_pairs.length).to eq(6)
    end

    it "all pairs each parts include 2 parts" do
      four_parts.all_pairs.each do |pair|
        expect(pair.length).to eq(2)
      end
    end

    it "sample all parts length is 20" do
      four_parts.all_pairs.each do |pair|
        pair.each do |part|
          expect(part.length).to eq(20)
        end
      end
    end

    it "sample all parts has sounds info" do
      four_parts.all_pairs.each do |pair|
        pair.each do |part|
          part.each do |key, sound|
            expect(sound["sound"].class).to eq(Integer)
          end
        end
      end 
    end

    it "sample all parts has progress info" do
      four_parts.all_pairs.each do |pair|
        pair.each do |part|
          part.each do |key, sound|
            expect(sound["progress"].class).to eq(Integer)
          end
        end
      end 
    end
  end

  describe "#outer_pair" do
    it "all pairs length is 1" do
      expect(four_parts.outer_pair.length).to eq(1)
    end

    it "all pairs each parts include 2 parts" do
      four_parts.outer_pair.each do |pair|
        expect(pair.length).to eq(2)
      end
    end

    it "sample all parts length is 20" do
      four_parts.outer_pair.each do |pair|
        pair.each do |part|
          expect(part.length).to eq(20)
        end
      end
    end

    it "sample all parts has sounds info" do
      four_parts.outer_pair.each do |pair|
        pair.each do |part|
          part.each do |key, sound|
            expect(sound["sound"].class).to eq(Integer)
          end
        end
      end 
    end

    it "sample all parts has progress info" do
      four_parts.outer_pair.each do |pair|
        pair.each do |part|
          part.each do |key, sound|
            expect(sound["progress"].class).to eq(Integer)
          end
        end
      end 
    end
  end

end