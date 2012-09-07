require 'tempfile'

module SpecRig
  class Exclusions
    def initialize
      @entries = Array.new
    end

    def add_pattern(pattern)
      @entries.push(pattern)
    end

    def path
      temp_file = Tempfile.new("rsync-exclusions")
      # exclusion patterns need to be prefixed with a hyphen
      @entries.each { |x| temp_file.print("- " + x, "\n") }
      temp_file.close
      temp_file.path
    end
  end
end
