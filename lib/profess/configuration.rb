require 'profess/core_ext/hash'
require 'toml'

module Profess

  class Configuration
    
    def initialize(leaf_directory = nil)

      if leaf_directory
        @config = load_cascaded(leaf_directory) 
      else
        @config = OpenStruct.new
      end

    end
    
    def method_missing(meth, *args, &block)
      @config.send(meth, *args, &block)
    end
    
    private
    
    def load_file(file)
      raise ArgumentError.new("'#{file}' does not exist or is not a file") unless File.file?(file) && File.readable?(file)
      TOML.load_file(file)
    end
    
    def load_cascaded(leaf_directory)
      
      raise ArgumentError.new("'#{leaf_directory}' does not exist or is not a directory") unless File.directory?(leaf_directory)
      
      config_files = get_config_filenames(leaf_directory)
      config = {}
      
      config_files.each do |file|
        
        new_config = load_file(file)
        config.deep_merge!(new_config)
        
      end
      
      config.to_ostruct_recursive
      
    end
    
    def get_config_filenames(start_dir)
      
      unless Project.path_in_project?(start_dir)
        raise ArgumentError.new("The path '#{start_dir}' is not within a Profess project.")
      end

      current = start_dir
      files = []

      loop do

        if Project.root?(current)
          files.unshift(Project.configuration_filename(current))
        else
          config_file = Dir[File.join(current, "*.#{Project::CONFIG_EXTENSION}")].first
          files.unshift(config_file) unless config_file.nil?
        end
        
        break if Project.root?(current)
        current = File.dirname(current)
        
      end
      
      files
        
    end

  end
  
end
