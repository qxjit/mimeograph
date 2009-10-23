require File.dirname(__FILE__) + "/../spec_helper"

describe Pathname do
  include SpecRig::Helpers

  it "should return itself from create" do
    pathname = workspace.path + "file"
    pathname.create("blah").should == pathname
  end

  it "should allow files to be created with content" do
    pathname = workspace.path + "test_file"
    pathname.create("somecontent").read.should == "somecontent"
  end

  it "should create files in subdirectories" do
    pathname = workspace.path.join("subdir/file")
    pathname.create("content").read.should == "content"
  end

  it "should create an empty file when no content is specified" do
    pathname = workspace.path + "file"
    pathname.create.read.should == ""
  end
end
