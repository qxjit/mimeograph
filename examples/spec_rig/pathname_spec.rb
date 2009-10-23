require File.dirname(__FILE__) + "/../spec_helper"

describe Pathname do
  include SpecRig::Helpers

  it "should return itself from create" do
    pathname = workspace.path + "file"
    pathname.create("blah").should == pathname
  end

  it "should allow files to be created with content" do
    workspace.path.join("file").create("somecontent").read.should == "somecontent"
  end

  it "should create files in subdirectories" do
    workspace.path.join("subdir/file").create("content").read.should == "content"
  end

  it "should create an empty file when no content is specified" do
    workspace.path.join("file").create.read.should == ""
  end

  it "should make a pipe" do
    workspace.path.join("pipe").make_pipe.should be_pipe
  end

  it "should make a chardev" do
    workspace.path.join("chardev").make_chardev.should be_chardev
  end

  it "should change group id" do
    workspace.path.join("file1").create
    workspace.path.join("file2").create.change_group_id
    workspace.path.join("file2").stat.gid.should_not == workspace.path.join("file1").stat.gid
  end
end
