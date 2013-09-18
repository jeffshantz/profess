require 'spec_helper'
require 'fileutils'

describe Profess::Configuration do

  context 'private instance methods' do
    
    let(:cfg) { Profess::Configuration.new }
    subject { cfg }

    describe '#load_file' do

      it 'throws an ArgumentError when the specified file does not exist' do
        expect { cfg.send(:load_file, 'nonexistent.toml') }.to raise_error(ArgumentError)
      end
      
      it 'throws an ArgumentError if the specified file is not a file' do
        expect { cfg.send(:load_file, '/') }.to raise_error(ArgumentError)
      end
      
      it 'loads the specified configuration file and returns a Hash' do
        
        File.open('cfg.toml', 'w') do |f|
         
          f.puts <<-EOF         	
[project]
  name = "proj"
 
[deck]
  
  [deck.author]
    name        = "Your name here"
    email       = "user@example.com"
    department  = "Department of Computer Science"
    institution = "Western University"
         EOF

        end
        
        config = cfg.send(:load_file, 'cfg.toml')
        
        config.should be_a(Hash)
        config["deck"].should be_a(Hash)
        
        config = config.to_ostruct_recursive
        
        config.project.name.should eq "proj"
        config.deck.author.name.should eq "Your name here"
        config.deck.author.email.should eq "user@example.com"
        config.deck.author.department.should eq "Department of Computer Science"
        config.deck.author.institution.should eq "Western University"
        
      end
      
    end
    
    describe '#get_config_filenames' do
      
      it 'returns the names of all configuration files from the project root down to the specified directory' do
        
        FileUtils.mkdir_p('/proj/config')
        Dir.mkdir('/proj/slides')
        Dir.mkdir('/proj/slides/deck1')
        FileUtils.touch('/proj/slides/deck1/deck.toml')
        FileUtils.touch('/proj/slides/slides.toml')
        FileUtils.touch('/proj/config/project.toml')
          
        cfg.send(:get_config_filenames, "/proj/slides/deck1").should eq %w{/proj/config/project.toml /proj/slides/slides.toml /proj/slides/deck1/deck.toml}
        
      end
      
      it 'throws an ArgumentError if the specified path is not within a project' do
        
        FileUtils.mkdir_p('/proj/slides/deck1')
        FileUtils.touch('/proj/slides/deck1/deck.toml')
        
        expect { cfg.send(:get_config_filenames, "/project/slides/deck1") }.to raise_error(ArgumentError)
      end
      
    end
    
    describe '#load_cascaded' do
      
      it 'returns an OpenStruct containing the merged data of all configuration files from the project root down to the specified directory' do

        Dir.mkdir('/proj')
        Dir.mkdir('/proj/config')
        Dir.mkdir('/proj/slides')
        Dir.mkdir('/proj/slides/deck1')
        
        File.open('/proj/config/project.toml', 'w') do |f|
          f.puts <<-EOF
[project]
  name = "proj"

[deck]

  [deck.author]
    name        = "Joe User"
    email       = "user@example.com"
    department  = "Department of Computer Science"
    institution = "The University of Western Ontario"
EOF
        end
        
        File.open('/proj/slides/slides.toml', 'w') do |f|
          f.puts <<-EOF
[deck]
  
  [deck.author]
    email = "bcaygeon@example.com"
EOF
        end
        
        File.open('/proj/slides/deck1/deck.toml', 'w') do |f|
          f.puts <<-EOF
[deck]

  title = "deck1"
  
  [deck.author]
    name        = "Bob Caygeon"
    institution = "Western University"
EOF
        end
        
        config = cfg.send(:load_cascaded, "/proj/slides/deck1")
        config.should be_an(OpenStruct)
        config.project.name.should eq "proj"
        config.deck.title.should eq "deck1"
        config.deck.author.name.should eq "Bob Caygeon"
        config.deck.author.email.should eq "bcaygeon@example.com"
        config.deck.author.department.should eq "Department of Computer Science"
        config.deck.author.institution.should eq "Western University"

      end
      
      it 'throws an ArgumentError if the specified path is not within a project' do
        
        FileUtils.mkdir_p('/proj/slides/deck1')
        FileUtils.touch('/proj/slides/deck1/deck.toml')
        
        expect { cfg.send(:load_cascaded, "/project/slides/deck1") }.to raise_error(ArgumentError)
      end
      
      it 'throws an ArgumentError if the specified path does not exist' do        
        expect { cfg.send(:load_cascaded, "/project/slides/deck1") }.to raise_error(ArgumentError)
      end
      
      it 'throws an ArgumentError if the specified path is not a file' do        
        FileUtils.touch('/proj')
        expect { cfg.send(:load_cascaded, "/proj") }.to raise_error(ArgumentError)
      end
      
    end
    
  end
  
end