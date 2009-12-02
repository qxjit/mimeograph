require 'tmpdir'

module SpecRig
  class Workspace
    attr_reader :source, :destination, :exclusions

    def initialize
      @directory = Pathname.new(Dir.mktmpdir)
      @source = @directory + "source"
      @source.mkdir
      @destination = @directory + "destination"
      @destination.mkdir
	  @exclusions = Exclusions.new
    end

    def path
      @directory
    end

    def entries
      @directory.entries.map { |e| e.to_s }
    end

    def to_str
      @directory.to_s
    end
  end
end
