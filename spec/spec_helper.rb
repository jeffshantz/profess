require 'profess'
require 'fakefs'
require 'fileutils'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  
  config.after(:each) do
    FakeFS::FileSystem.clear
    #FileUtils.rm_rf('tmp')
  end

end
