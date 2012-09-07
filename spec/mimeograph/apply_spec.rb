require File.dirname(__FILE__) + "/../spec_helper"

describe "mimeograph apply" do
  include SpecRig::Helpers

  it "should not copy any files if diff file is empty" do
    setup_diff_contents ''

    source.join("file1").create("content1")
    source.join("subdir", "file2").create("content2")

    mimeograph(:apply, source, destination).should be_successful

    destination.join("file1").should_not exist
    destination.join("subdir", "file2").should_not exist
  end

  it "should copy files that are in the diff file" do
    setup_diff_contents <<-end_diff
file1
subdir/
subdir/file2
    end_diff

    source.join("file1").create("content1")
    source.join("subdir", "file2").create("content2")

    mimeograph(:apply, source, destination).should be_successful

    destination.join("file1").read.should == "content1"
    destination.join("subdir", "file2").read.should == "content2"
  end
end


