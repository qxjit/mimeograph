module MimeographSupport
  def mimeograph(*args)
    mimeograph_path = File.expand_path File.dirname(__FILE__) + "/../../bin/mimeograph"
    SpecRig::Command.new("sudo", mimeograph_path, *args)
    .in_directory(cwd).tap do |command|
      command.result # force running
    end
  end
end

RSpec.configure do |c|
  c.include MimeographSupport
end
