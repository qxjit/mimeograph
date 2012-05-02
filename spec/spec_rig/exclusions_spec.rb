require File.dirname(__FILE__) + "/../spec_helper"

module SpecRig
  describe Exclusions do
    it "should create a temporary file with the noted exclusion patterns" do
      test_data = [ "one", "two", "three", "four" ]
	  expected_file_data = Array.new
	  test_data.each { |x| expected_file_data.push("- " + x) }
	  exclusions = Exclusions.new
	  test_data.each { |x| exclusions.add_pattern(x) }
	  actual_file_data = Array.new
	  File.new(exclusions.path).each_line { |x| actual_file_data.push(x.chomp) }
	  actual_file_data.should == expected_file_data
    end
  end
end
