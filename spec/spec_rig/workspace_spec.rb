require File.dirname(__FILE__) + "/../spec_helper"

module SpecRig
  describe Workspace do
    it "should have a unique directory" do
      workspace_1 = Workspace.new
      workspace_2 = Workspace.new

      FileUtils.touch File.join(workspace_1, "/new_file")
      Dir.entries(workspace_2).should == [".", ".."]
    end
  end
end
