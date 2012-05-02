require File.dirname(__FILE__) + "/../spec_helper"

describe "mimeograph diff" do
  include SpecRig::Helpers

  it "should not copy any files from source to destination" do
    source.join("file1").create("content1")
    source.join("subdir", "file2").create("content2")

    mimeograph(:diff, source, destination).should be_successful

    destination.join("file1").should_not exist
    destination.join("subdir", "file2").should_not exist
  end

  it "should list the files that would be copied" do
    source.join("file1").create("content1")

    mimeograph(:diff, source, destination).output.should include "file1"
  end
end

