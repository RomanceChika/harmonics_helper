require "harmonics_helper"
require "json"

def file_path(file_name)
  File.join(File.dirname(__FILE__), '../files/' + file_name)
end
xml = open(file_path("GoodSample.xml"))
formatter = HarmonicsHelper::ProhibitFormatter.new(xml)
result_hash = formatter.result_hash

puts result_hash["prohibit_info"]