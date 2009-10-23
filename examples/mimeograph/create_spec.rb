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
    source.join("symlink").make_symlink("target")
    mimeograph(:create, source, destination).should be_successful
    destination.join("symlink").should be_symlink
    destination.join("symlink").readlink.to_s.should == "target"
  end

  it "should preserve special files" do
    SpecRig::Command.new("mkfifo", source + "fifo").should be_successful
    mimeograph(:create, source, destination).should be_successful
    destination.join("fifo").should be_pipe
  end

  def mimeograph(*args)
    mimeograph_path = File.expand_path File.dirname(__FILE__) + "/../../bin/mimeograph"
    SpecRig::Command.new mimeograph_path, *args
  end
end
