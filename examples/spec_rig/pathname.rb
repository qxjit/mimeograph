require File.dirname(__FILE__) + "/../spec_helper"

describe Pathname do
  it "should allow files to be created with content" do
    workspace = SpecRig::Workspace.new
    pathname = Pathname.new(workspace) + "test_file"
    pathname.write "somecontent"
    pathname.read.should == "somecontent"
  end
end
