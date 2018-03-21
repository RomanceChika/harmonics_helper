require "harmonics_helper/prohibit_checker"

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
    def prohibit_info()
      details = []
      details << all_prohibit_detail
      details << consecutive_prohibit_detail
      details << code_prohibit_detail
      { "prohibit_info" => details }
    end

    # get detail about all prohibit
    #
    # @return[Hash]
    def all_prohibit_detail()
      detail = []
      detail << "result check all prohibit"
      detail << prohibit_message(has_any_prohibit?)
      { "all_prohibit" => detail }
    end

    # get detail about consecutive prohibit
    #
    # @return[Hash]
    def consecutive_prohibit_detail()
      detail = []
      detail << "result check consecutive octave or fifth"
      detail << prohibit_message(has_consecutive_prohibit?)
      @prohibit_checker.consecutive_prohibits_all.map{ |prohibits| prohibits.map{ |prohibit| prohibit ? "!!NG!!" : "--OK--" } }.each{ |prohibits| detail << prohibits } 
      { "consecutive_prohibit" => detail }
    end

    # get detail about code prohibit
    #
    # @return[Hash]
    def code_prohibit_detail()
      detail = []
      detail << "result check codes are fulfilled"
      detail << prohibit_message(has_code_prohibit?)
      detail << @prohibit_checker.code_configured_all.map{ |code| code ? "--OK--" : "!!NG!!"}
      { "code_prohibit" => detail }
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
  end
end