require "rexml/document"
require "yaml"

module HarmonicsHelper

  # parse xml files
  class Parser
    
    # initialize
    # set document by file name
    def initialize(file_name)
      @document = REXML::Document.new(open(file_path(file_name)))
      @sounds = YAML.load_file(config_path("sounds.yml"))
    end

    # get part voice numbers removed duplication
    #
    # @return [Array] part array as integers
    def parts()
      REXML::XPath.each(@document, "//note/voice/text()"){ |element| element }
        .map{ |text| text.to_s().to_i() }
        .uniq
        .sort
    end

    # get all sounds from start to end as numbers of part
    #
    # @return [Array] sounds as numbers array
    def sounds(part)
      REXML::XPath.each(@document, "//note"){ |element| element }
        .select{ |e| e.elements["voice"].text.to_i() == part}
        .map{ |e| e.elements["pitch/octave"].text.to_i() * 12 + @sounds[e.elements["pitch/step"].text]}
    end


    # ! information about rhythem. maybe used nonchode tone?

    # get beat numerator
    # 
    # @return [Integer] beat
    def beat()
      @document.elements["//attributes/time/beats"].text.to_i()
    end

    # get beat denominator
    #
    # @return [Integer] beat_type
    def beat_type()
      @document.elements["//attributes/time/beat-type"].text.to_i()
    end

    # get all sounds dulation(unit of length) of part
    #
    # @return [Array] durations as numbers array
    def durations(part)
      REXML::XPath.each(@document, "//note"){ |element| element }
        .select{ |e| e.elements["voice"].text.to_i() == part}
        .map{ |e| e.elements["duration"].text.to_i() }
    end

    attr_accessor :document

    private
    # get full path of file name
    #
    # @params [String] file_name MusicXMLFileName
    # @return [String] full path of file
    def file_path(file_name)
      File.join(File.dirname(__FILE__), '../../files/' + file_name)
    end

    # get config full path it will be used by other files
    def config_path(file_name)
      File.join(File.dirname(__FILE__), '../../config/' + file_name)
    end

  end

end