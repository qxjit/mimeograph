require File.dirname(__FILE__) + "/../spec_helper"

describe "mimegraph create" do
  include SpecRig::Helpers

  it "should copy all files from source to destination" do
    workspace.source.join("file1").create("content1")
    workspace.source.join("subdir", "file2").create("content2")

    mimeograph(:create, workspace.source, workspace.destination).should be_successful

    workspace.destination.join("file1").read.should == "content1"
    workspace.destination.join("subdir", "file2").read.should == "content2"
  end

  it "should perserve permissions" do
    workspace.source.join("file").create.chmod(0666)

    mimeograph(:create, workspace.source, workspace.destination).should be_successful

    (workspace.destination.join("file").stat.mode & 0777).should == 0666
  end

  it "should preserve timestamps" do
    workspace.source.join("file").create.utime Time.now, Time.parse("12/2/2008")
    mimeograph(:create, workspace.source, workspace.destination).should be_successful
    workspace.destination.join("file").stat.mtime.should == workspace.source.join("file").stat.mtime
  end

  def mimeograph(*args)
    mimeograph_path = File.expand_path File.dirname(__FILE__) + "/../../bin/mimeograph"
    SpecRig::Command.new mimeograph_path, *args
  end
end
