require 'profess'
require 'fileutils'

Dir[File.join(File.dirname(__FILE__), "/support/**/*.rb")].each {|f| require f}

require 'fakefs'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  
  config.include ConfigurationHelper
  
  config.after(:each) do
    FakeFS::FileSystem.clear
  end

end
