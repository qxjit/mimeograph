require File.dirname(__FILE__) + "/../spec_helper"

module SpecRig
  describe Workspace do
    it "should have a unique directory" do
      workspace_1 = Workspace.new
      workspace_2 = Workspace.new

      FileUtils.touch File.join(workspace_1, "new_file")

      workspace_1.entries.should include("new_file")
      workspace_2.entries.should_not include("new_file")
    end

    it "should have a source directory" do
      Workspace.new.source.should be_directory
    end

    it "should have a destination directory" do
      Workspace.new.destination.should be_directory
    end

    it "should have different source and destinations" do
      workspace = Workspace.new
      workspace.source.should_not == workspace.destination
    end
  end
end
