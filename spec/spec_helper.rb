require "bundler/setup"
require "harmonics_helper"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:all){
    parts = [1, 2, 5, 6]
    soprano_durations = [2, 2, 2, 2, 2, 2, 4, 4]
    alt_durations = [2, 2, 2, 2, 2, 2, 4, 4]
    tenor_durations = [2, 2, 2, 2, 2, 2, 4, 4]
    bass_durations = [2, 2, 2, 2, 2, 2, 4, 4]
    soprano_sounds = [64, 65, 64, 62, 60, 65, 62, 60]
    alt_sounds = [55, 57, 55, 55, 52, 57, 55, 52]
    tenor_sounds = [48, 48, 48, 47, 48, 48, 47, 48]
    bass_sounds = [36, 41, 36, 43, 45, 41, 43, 36]
    beat = 4
    beat_type = 4
  }
end
