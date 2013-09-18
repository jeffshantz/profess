require 'pathname'

module Profess
  
  class Project

    CONFIG_EXTENSION = "toml"
    CONFIG_FILENAME = "project.#{CONFIG_EXTENSION}"    
    
    class << self
      
      def root?(directory)
        
        File.directory?(File.join(directory, "config")) &&
        File.exists?(File.join(directory, "config", CONFIG_FILENAME))
        
      end
      
      def configuration_filename(project_root)
                
        if root?(project_root)
          File.join(project_root, 'config', CONFIG_FILENAME)
        else
          nil
        end
        
      end
      
      def path_in_project?(path)
        
        path = Pathname.new(path)
      
        loop do
          return true if root?(path)
          
          break if path.parent == path
          path = path.parent
        end
      
        false
        
      end
      
    end
    
  end
  
end