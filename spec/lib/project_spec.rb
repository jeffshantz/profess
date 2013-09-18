require 'spec_helper'

describe Profess::Project do

  it 'should define the constant CONFIG_EXTENSION' do
    Profess::Project.constants.should include(:CONFIG_EXTENSION)
  end

  context 'class members' do
  
    subject { Profess::Project }

    it { should respond_to(:root?).with(1).argument }
    
    context '::root?' do
      
      it 'returns true if passed the root of a project' do
        Dir.mkdir('/config')
        FileUtils.touch('/config/project.toml')
        Profess::Project.root?("/").should be_true
      end
      
      it 'returns false if not passed the root of a project' do
        Profess::Project.root?("/").should be_false
      end
      
    end
    
    it { should respond_to(:configuration_filename).with(1).argument }
    
    context '::configuration_filename' do
      
      it 'returns the full path to the project configuration filename given the project root' do
        Dir.mkdir('/config')
        FileUtils.touch('/config/project.toml')
        Profess::Project.configuration_filename("/").should eq "/config/project.toml"
      end
      
      it 'returns nil if the specified directory is not a project root' do
        Profess::Project.configuration_filename("/").should be_nil
      end
      
    end

    it { should respond_to(:path_in_project?).with(1).argument }
    
    context '::path_in_project?' do
      
      it 'returns true for the root of a project' do
        FileUtils.mkdir_p('/proj/config')
        FileUtils.touch('/proj/config/project.toml')
        Profess::Project.path_in_project?('/proj').should be_true
      end
      
      it 'returns true for a subdirectory of a project' do
        FileUtils.mkdir_p('/proj/config')
        FileUtils.mkdir_p('/proj/slides/deck1')
        FileUtils.touch('/proj/config/project.toml')
        Profess::Project.path_in_project?('/proj/slides/deck1').should be_true
      end
      
      it 'returns false for a path outside a project' do
        FileUtils.mkdir_p('/proj/config')
        FileUtils.mkdir_p('/proj/slides/deck1')
        Profess::Project.path_in_project?('/proj/slides/deck1').should be_false
      end
      
    end
    
  end
  
end