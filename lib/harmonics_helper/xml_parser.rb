require "rexml/document"
require "yaml"
require "harmonics_helper/etc/path_helper"

module HarmonicsHelper

  # parse xml files
  class Parser
    include Helper
    
    # map sounds name to sounds number
    @@sounds = YAML.load_file(Helper.config_path("sounds.yml"))
    
    # initialize
    # set document by file name
    # set sounds by config
    def initialize(file_name)
      @document = REXML::Document.new(open(file_path(file_name)))
    end

    # get part voice numbers removed duplication
    #
    # @return [Array] part array as integers
    def parts()
      REXML::XPath.each(@document, "//note/voice/text()"){ |element| element }
        .map{ |text| text.to_s.to_i }
        .uniq
        .sort
    end

    # get all sounds from start to end as numbers of part
    #
    # @return [Array] sounds as numbers array
    def sounds(part)
      REXML::XPath.each(@document, "//note"){ |element| element }
        .select{ |e| e.elements["voice"].text.to_i == part}
        .map{ |e| e.elements["pitch/octave"].text.to_i * 12 + @@sounds[e.elements["pitch/step"].text]}
    end


    # ! information about rhythem. maybe used when nonchode tone include?

    # get beat numerator
    # 
    # @return [Integer] beat
    def beat()
      @document.elements["//attributes/time/beats"].text.to_i
    end

    # get beat denominator
    #
    # @return [Integer] beat_type
    def beat_type()
      @document.elements["//attributes/time/beat-type"].text.to_i
    end

    # get all sounds dulation(unit of length) of part
    #
    # @return [Array] durations as numbers array
    def durations(part)
      REXML::XPath.each(@document, "//note"){ |element| element }
        .select{ |e| e.elements["voice"].text.to_i == part}
        .map{ |e| e.elements["duration"].text.to_i }
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

  end

end