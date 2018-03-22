require "harmonics_helper/prohibit_checker"
require "json"

module HarmonicsHelper

  class ProhibitFormatter

    @@success_message = "[Success] Prohibits are not found"
    @@failure_message = "[Failure] Prohibits may be exist, please check yourself again"

    def initialize(xml)
      @parser = Parser.new(xml)
      @prohibit_checker = ProhibitChecker.new(@parser)
    end


    # get details about all prohibit
    #
    # @return[Hash]
    def result_hash()
      details = {}  
      details.merge!(all_prohibit_detail)
      details.merge!(consecutive_prohibit_detail)
      details.merge!(code_prohibit_detail)
      details
    end

    # get detail about all prohibit
    #
    # @return[Hash]
    def all_prohibit_detail()
      detail = {} 
      detail.merge!(header("result check all prohibit"))
      detail.merge!(message(has_any_prohibit?))
      { "all_prohibit" => detail }
    end

    # get detail about consecutive prohibit
    #
    # @return[Hash]
    def consecutive_prohibit_detail()
      detail = {}
      detail.merge!(header("result check consecutive octave or fifth"))
      detail.merge!(message(has_consecutive_prohibit?))
      detail_array = []
      @prohibit_checker.consecutive_prohibits_all
        .map{ |prohibits| prohibits.map{ |prohibit| prohibit ? "!!NG!!" : "--OK--" } }
        .each{ |prohibits| detail_array << slice_detail(prohibits) } 
      detail.merge!(details(detail_array))
      { "consecutive_prohibit" => detail }
    end

    # get detail about code prohibit
    #
    # @return[Hash]
    def code_prohibit_detail()
      detail = {}
      detail.merge!(header("result check codes are fulfilled"))
      detail.merge!(message(has_code_prohibit?))
      detail_array = slice_detail(@prohibit_checker.code_configured_all.map{ |code| code ? "--OK--" : "!!NG!!"})
      detail.merge!(details(detail_array))
      { "code_prohibit" => detail }
    end
    
    # @params [String] header_message 
    # @return [Hash]
    def header(header_message)
      { "header" => header_message }
    end

    # @params [Boolean] has_prohibit 
    # @return [Hash]
    def message(has_prohibit)
      { "message" => prohibit_message(has_prohibit) }
    end

    # @params [Array] detail_array
    # @return [Hash]
    def details(detail_array)
      { "details" => detail_array }
    end

    # slice detail by measures
    #
    # @return[Hash]
    def slice_detail(array)
      array.each_slice(measure_slicer).to_a.map.with_index { |detail, index| {index+1 => detail } }
    end

    # get prohibit message
    #
    # @return[String]
    def prohibit_message(has_prohibit)
      (has_prohibit) ? @@failure_message : @@success_message
    end

    # has consecutive prohibit
    #
    # @return [Boolean]
    def has_consecutive_prohibit?()
      @prohibit_checker.consecutive_prohibits_all.each{ |prohibits| }.flatten.any?
    end

    # has code prohibit
    # ex. C,F,G not code, C,G has no 3rd bad code
    #
    # @return [Boolean]
    def has_code_prohibit?()
      !@prohibit_checker.code_configured_all.all?
    end

    # has any prohibit
    #
    # @return [Boolean]
    def has_any_prohibit?
      has_consecutive_prohibit? || has_code_prohibit?
    end

    # each measure size corrected by divisions
    #
    # @return [Integer]
    def measure_slicer()
      @parser.divisions * @parser.beat_type
    end

  end
end