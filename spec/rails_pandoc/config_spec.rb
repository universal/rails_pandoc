require 'spec_helper'

describe RailsPandoc::Config do

  describe "executable" do
    it "returns executable" do
      RailsPandoc::Config.executable.should == "pandoc"
    end

    it "has valid executable set" do
      RailsPandoc::Config.valid_executable.should_not be_nil
    end

    it "sets valid executable to false for non existing file" do
      RailsPandoc::Config.executable = "non_existing_file"
      RailsPandoc::Config.valid_executable.should be_false
    end
  end

  describe "sanitize_executable" do
    it "returns sanitize" do
      RailsPandoc::Config.sanitize_executable.should == "sanitize"
    end

    it "has valid sanitize set" do
      RailsPandoc::Config.valid_sanitize.should_not be_nil
    end

    it "sets valid sanitize to false for non existing file" do
      RailsPandoc::Config.sanitize_executable = "non_existing_file"
      RailsPandoc::Config.valid_sanitize.should be_false
    end
  end
end