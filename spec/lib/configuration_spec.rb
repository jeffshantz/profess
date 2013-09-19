require 'spec_helper'
require 'fileutils'

describe Profess::Configuration do

  before(:each) do
    setup_sample_project
  end
  
  context 'public methods' do
    
    context 'during initialization' do
    
      it 'does not require a path to be specified' do
        expect { Profess::Configuration.new }.to_not raise_error
      end
      
      it 'loads the configuration from the project root down to the specified path' do
        cfg = Profess::Configuration.new        
        cfg.stub(:load_file).and_return({ hello: 'world' })
        cfg.should_receive(:load_file).exactly(3).times
        cfg.send(:initialize, "/proj/slides/deck1")
        cfg.hello.should eq 'world'
      end
      
    end
    
    it 'allows new configuration settings to be defined' do
      cfg = Profess::Configuration.new   
      cfg.maggie = 'dog'
      cfg.maggie.should eq 'dog'
    end
    
    it 'correctly handles nested configuration settings' do
      cfg = Profess::Configuration.new("/proj/slides/deck1")
      cfg.deck.author.name.should eq "Bob Caygeon"
    end
    
  end
  
  context 'private instance methods' do
    
    let(:cfg) { Profess::Configuration.new }
    subject { cfg }
    
    describe '#load_file' do

      it 'throws an ArgumentError when the specified file does not exist' do
        expect { cfg.send(:load_file, 'nonexistent.toml') }.to raise_error(ArgumentError)
      end
      
      it 'throws an ArgumentError if the specified file is not a file' do
        expect { cfg.send(:load_file, '/proj') }.to raise_error(ArgumentError)
      end
      
      it 'loads the specified configuration file and returns a Hash' do
        
        config = cfg.send(:load_file, '/proj/config/project.toml')
        
        config.should be_a(Hash)
        config["deck"].should be_a(Hash)
        
        config = config.to_ostruct_recursive
        
        config.project.name.should eq "proj"
        config.deck.author.name.should eq "Joe User"
        config.deck.author.email.should eq "user@example.com"
        config.deck.author.department.should eq "Department of Computer Science"
        config.deck.author.institution.should eq "The University of Western Ontario"
        
      end
      
    end
    
    describe '#get_config_filenames' do
      
      it 'returns the names of all configuration files from the project root down to the specified directory' do  
        cfg.send(:get_config_filenames, "/proj/slides/deck1").should eq %w{/proj/config/project.toml /proj/slides/slides.toml /proj/slides/deck1/deck.toml}        
      end
      
      it 'throws an ArgumentError if the specified path is not within a project' do
        FileUtils.rm('/proj/config/project.toml')
        expect { cfg.send(:get_config_filenames, "/proj/slides/deck1") }.to raise_error(ArgumentError)
      end
      
    end
    
    describe '#load_cascaded' do
      
      it 'returns an OpenStruct containing the merged data of all configuration files from the project root down to the specified directory' do

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
        FileUtils.rm('/proj/config/project.toml')
        expect { cfg.send(:load_cascaded, "/proj/slides/deck1") }.to raise_error(ArgumentError)
      end
      
      it 'throws an ArgumentError if the specified path does not exist' do        
        expect { cfg.send(:load_cascaded, "/project/slides/deck1") }.to raise_error(ArgumentError)
      end
      
      it 'throws an ArgumentError if the specified path is not a directory' do        
        expect { cfg.send(:load_cascaded, "/proj/config/project.toml") }.to raise_error(ArgumentError)
      end
      
    end
    
  end
  
end