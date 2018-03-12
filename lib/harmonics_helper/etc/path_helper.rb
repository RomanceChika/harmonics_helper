module HarmonicsHelper

  module Helper

    # get config full path
    def self.config_path(file_name)
      File.join(File.dirname(__FILE__), '../../../config/' + file_name)
    end
    
  end

end