RSpec.describe HarmonicsHelper::Part::FourParts do
  PARTS = [1, 2, 5, 6]
  SOPRANO_DURATION = [2, 2, 2, 2, 2, 2, 4, 4]
  ALT_DURATION = [2, 2, 2, 2, 2, 2, 4, 4]
  TENOR_DURATION = [2, 2, 2, 2, 2, 2, 4, 4]
  BASS_DURATION = [2, 2, 2, 2, 2, 2, 4, 4]
  SOPRANO_SOUND = [64, 65, 64, 62, 60, 65, 62, 60]
  ALT_SOUND = [55, 57, 55, 55, 52, 57, 55, 52]
  TENOR_SOUND = [48, 48, 48, 47, 48, 48, 47, 48]
  BASS_SOUND = [36, 41, 36, 43, 45, 41, 43, 36]
  BEAT = 4
  BEAT_TYPE = 4
  before do
    @parser_mock = double("Parser mock")
    @strange_parts_parsermock = double("ParserBad mock")
    @strange_durations_parsermock = double("ParserBad2 mock")
    allow(@parser_mock).to receive(:beat).and_return(BEAT)
    allow(@parser_mock).to receive(:beat_type).and_return(BEAT_TYPE)
    allow(@parser_mock).to receive(:sounds).with(1).and_return(SOPRANO_SOUND)
    allow(@parser_mock).to receive(:sounds).with(2).and_return(ALT_SOUND)
    allow(@parser_mock).to receive(:sounds).with(5).and_return(TENOR_SOUND)
    allow(@parser_mock).to receive(:sounds).with(6).and_return(BASS_SOUND)
    allow(@parser_mock).to receive(:durations).with(1).and_return(SOPRANO_DURATION)
    allow(@parser_mock).to receive(:durations).with(2).and_return(ALT_DURATION)
    allow(@parser_mock).to receive(:durations).with(5).and_return(TENOR_DURATION)
    allow(@parser_mock).to receive(:durations).with(6).and_return(BASS_DURATION)
    allow(@parser_mock).to receive(:parts).and_return(PARTS)

    allow(@strange_parts_parsermock).to receive(:parts).and_return([1, 2])

    allow(@strange_durations_parsermock).to receive(:parts).and_return(PARTS)
    allow(@strange_durations_parsermock).to receive(:durations).with(1).and_return([2, 2, 2])
    allow(@strange_durations_parsermock).to receive(:durations).with(2).and_return(ALT_DURATION)
    allow(@strange_durations_parsermock).to receive(:durations).with(5).and_return(TENOR_DURATION)
    allow(@strange_durations_parsermock).to receive(:durations).with(6).and_return(BASS_DURATION)
  end

  describe "#initialize" do
    describe "fail to initialize bad parser" do
      it "if parts length is not 4 raise error" do
        expect { HarmonicsHelper::Part::FourParts.new(@strange_parts_parsermock) }.to raise_error(HarmonicsHelper::Errors::FourPartsError)
      end
      it "if parts duration is not common raise error" do
        expect { HarmonicsHelper::Part::FourParts.new(@strange_durations_parsermock) }.to raise_error(HarmonicsHelper::Errors::DurationUnmatchError)
      end
    end
    describe "success to initialize good parser" do
      it "if parts length is 4 not raise error" do
        expect { HarmonicsHelper::Part::FourParts.new(@parser_mock)}.not_to raise_error(Exception)
      end
    end
  end


end