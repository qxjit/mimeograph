require File.dirname(__FILE__) + "/../spec_helper"

module SpecRig
  describe Command do
    it "should be_successful when command succeeds" do
      Command.new("echo", "hi").should be_successful
    end

    it "should_not be_successful when command fails" do
      Command.new("ls", "foobar").should_not be_successful
    end
  end
end

