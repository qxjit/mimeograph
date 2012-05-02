module SpecRig
  module Helpers
    def workspace
      @workspace ||= Workspace.new
    end

    def source
      workspace.source
    end

    def destination
      workspace.destination
    end

    def exclusions
      workspace.exclusions
    end
  end
end
