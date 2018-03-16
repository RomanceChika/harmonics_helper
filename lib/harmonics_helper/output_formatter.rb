require "harmonics_helper/prohibit_checker"

module HarmonicsHelper

  class OutputFormatter

    def initialize(prohibit_checker, file_name="../../../result.txt")
      @prohibit_checker = prohibit_checker
      @file_name = file_name
    end

    # output 
    # TODO: output should be formatted
    def output
      puts "conencutive octave or fifth"
      puts "true is probably prohibit"
      puts @prohibit_checker.concencutive_prohibits_all.each{ |prohibits| }.flatten.any?
      @prohibit_checker.concencutive_prohibits_all.each{ |prohibits| p prohibits }
      puts "is code?"
      puts "false is not code or has not 3rd tone"
      p @prohibit_checker.code_configured_all.all?
      p @prohibit_checker.code_configured_all
    end
  end
end