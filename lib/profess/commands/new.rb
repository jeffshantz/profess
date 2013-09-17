require 'thor'
require 'ostruct'
require 'pathname'

module Profess
  class New < Thor

    include Thor::Actions

    def self.source_root
      File.expand_path("../", File.dirname(__FILE__))
    end

    desc "project [name]", "Creates a new project"
    def project(name)
      empty_directory(name)
      empty_directory(File.join(name, 'common'))
      empty_directory(File.join(name, 'config'))
      empty_directory(File.join(name, 'output'))
      empty_directory(File.join(name, 'slides'))
      template('templates/project.tt', File.join(name, 'config', 'project.toml'), { project_name: name })
    end

    desc "deck [name]", "Creates a new slide deck within a project"
    def deck(name)

      project_root = get_project_root
      
      if project_root.nil?
        puts <<-EOF
Cannot find the project root.

You must run this command from within a Profess project.
Use 'profess new project PROJECTNAME' to create a project.

        EOF
        exit -1
      end
      
      empty_directory(File.join(project_root, 'slides'))
      empty_directory(File.join(project_root, 'slides', name))
      template('templates/deck.tt', File.join(project_root, 'slides', name, 'deck.toml'), { deck_name: name })

    end
    
    private
    
    def get_project_root
      
      path = Pathname.new(Dir.pwd)
      
      loop do
        if File.directory?(File.join(path, 'config')) &&
          File.exists?(File.join(path, 'config', 'project.toml'))
          return path
        end
        
        break if path.parent == path
        path = path.parent
      end
      
      nil
      
    end

  end
end

