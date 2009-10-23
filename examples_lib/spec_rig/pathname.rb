require 'pathname'

Pathname.class_eval do
  def create(content = "")
    self.parent.mkpath
    File.open(self, 'w') { |io| io << content }
    self
  end
  
  def make_pipe
    SpecRig::Command.new("mkfifo", self).run_successfully
    self
  end

  def make_chardev
    SpecRig::Command.new("sudo", File.dirname(__FILE__) + "/make_device", self).run_successfully
    self
  end
end
