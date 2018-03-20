require "harmonics_helper/prohibit_checker"

module HarmonicsHelper

  class OutputFormatter

    @@success_message = "[Success] Prohibits are not found"
    @@failure_message = "[Failure] Prohibits are exist, please check yourself again"

    def initialize(prohibit_checker, file_name="../../../result.txt")
      @prohibit_checker = prohibit_checker
      @file_name = file_name
    end

    # output 
    # TODO: output should be formatted
    def output
      puts "consecutive octave or fifth"
      puts @prohibit_checker.consecutive_prohibits_all.each{ |prohibits| }.flatten.any? ? @@failure_message : @@success_message
      @prohibit_checker.consecutive_prohibits_all.map{ |prohibits| prohibits.map{ |prohibit| prohibit ? "!!NG!!" : "--OK--" } }.each{ |prohibits| p prohibits }
      puts "is code?"
      p @prohibit_checker.code_configured_all.all? ? @@success_message : @@failure_message
      p @prohibit_checker.code_configured_all.map{ |code| code ? "--OK--" : "!!NG!!"}
      if has_prohibit?
        puts "[Success] Prohibit is not found"
      else
        puts "[Failure] Prohibit is found"
      end
    end

    def has_prohibit?
      !@prohibit_checker.consecutive_prohibits_all.each{ |prohibits| }.flatten.any? || @prohibit_checker.code_configured_all.all?
    end
  end
end