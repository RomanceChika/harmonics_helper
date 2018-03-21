require "harmonics_helper"

def file_path(file_name)
  File.join(File.dirname(__FILE__), '../files/' + file_name)
end
xml = open(file_path("BadSample.xml"))
formatter = HarmonicsHelper::ProhibitFormatter.new(xml)
p formatter.prohibit_info