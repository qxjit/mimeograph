require File.dirname(__FILE__) + "/../spec_helper"

describe "mimegraph create" do
  it "should copy all files from source to destination" do
    workspace = SpecRig::Workspace.new

    workspace.source.join("file1").write("content1")
    workspace.source.join("subdir", "file2").write("content2")

    mimeograph(:create, workspace.source, workspace.destination).should be_successful

    workspace.destination.join("file1").read.should == "content1"
    workspace.destination.join("subdir", "file2").read.should == "content2"
  end

  def mimeograph(*args)
    mimeograph_path = File.expand_path File.dirname(__FILE__) + "/../../bin/mimeograph"
    SpecRig::Command.new mimeograph_path, *args
  end
end
