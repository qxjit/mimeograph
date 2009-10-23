require 'tmpdir'

module SpecRig
  class Workspace
    def initialize
      @directory = Dir.mktmpdir
    end

    def to_str
      @directory
    end
  end
end
