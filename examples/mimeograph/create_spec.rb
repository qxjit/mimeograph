require File.dirname(__FILE__) + "/../spec_helper"

describe "mimegraph create" do
  include SpecRig::Helpers

  it "should copy all files from source to destination" do
    source.join("file1").create("content1")
    source.join("subdir", "file2").create("content2")

    mimeograph(:create, source, destination).should be_successful

    destination.join("file1").read.should == "content1"
    destination.join("subdir", "file2").read.should == "content2"
  end

  it "should perserve permissions" do
    source.join("file").create.chmod(0666)
    mimeograph(:create, source, destination).should be_successful
    (destination.join("file").stat.mode & 0777).should == 0666
  end

  it "should preserve timestamps" do
    source.join("file").create.utime Time.now, Time.parse("12/2/2008")
    mimeograph(:create, source, destination).should be_successful
    destination.join("file").mtime.should == source.join("file").mtime
  end

  it "should preserve symlinks" do
    source.join("symlink").make_symlink source.join("target").basename
    mimeograph(:create, source, destination).should be_successful
    destination.join("symlink").should be_symlink_to(destination.join("target").basename)
  end

  it "should preserve hardlinks" do
    source.join("file2").make_link source.join("file1").create
    mimeograph(:create, source, destination).should be_successful
    destination.join("file2").should be_hardlink_to(destination.join("file1"))
  end

  it "should preserve special files" do
    source.join("pipe").make_pipe
    mimeograph(:create, source, destination).should be_successful
    destination.join("pipe").should be_pipe
  end
  
  it "should preserve device files" do
    source.join("device").make_chardev
    mimeograph(:create, source, destination).should be_successful
    destination.join("device").should be_chardev
  end
  
  it "should preserve ownership" do
    source.join("file").create
    mimeograph(:create, source, destination).should be_successful
    destination.join("file").stat.uid.should == source.join("file").stat.uid
  end

  it "should preserve group" do
    source.join("file").create.change_group_id
    mimeograph(:create, source, destination).should be_successful
    destination.join("file").stat.gid.should == source.join("file").stat.gid
  end

  def mimeograph(*args)
    mimeograph_path = File.expand_path File.dirname(__FILE__) + "/../../bin/mimeograph"
    SpecRig::Command.new "sudo", mimeograph_path, *args
  end
end
