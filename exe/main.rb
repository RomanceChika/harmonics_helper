require "harmonics_helper"
require "json"

def file_path(file_name)
  File.join(File.dirname(__FILE__), '../files/' + file_name)
end
xml = open(file_path("BadSample.xml"))
formatter = HarmonicsHelper::ProhibitFormatter.new(xml)
puts JSON.pretty_generate(formatter.all_result_hash)
puts JSON.pretty_generate(formatter.each_result_hash)