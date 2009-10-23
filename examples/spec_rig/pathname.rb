require File.dirname(__FILE__) + "/../spec_helper"

describe Pathname do
  it "should return itself from create" do
    workspace = SpecRig::Workspace.new
    pathname = workspace.path + "file"
    pathname.create("blah").should == pathname
  end

  it "should allow files to be created with content" do
    workspace = SpecRig::Workspace.new
    pathname = workspace.path + "test_file"
    pathname.create("somecontent").read.should == "somecontent"
  end

  it "should create files in subdirectories" do
    workspace = SpecRig::Workspace.new
    pathname = workspace.path.join("subdir/file")
    pathname.create("content").read.should == "content"
  end

  it "should create an empty file when no content is specified" do
    workspace = SpecRig::Workspace.new
    pathname = workspace.path + "file"
    pathname.create.read.should == ""
  end
end
