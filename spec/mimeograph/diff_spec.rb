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

  it "save files that would be copied to a file" do
    source.join("file1").create("content1")

    mimeograph(:diff, source, destination)

    File.read(cwd.join("mimeograph.diff")).should include "file1"
  end

  it "each non blank line in diff file should be file from source" do
    source.join("file1").create("content1")

    mimeograph(:diff, source, destination)

    File.read(cwd.join("mimeograph.diff")).each_line do |line|
      if !line.strip.empty?
        source.join(line.strip).should exist
      end
    end
  end
end


