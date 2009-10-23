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

  def change_group_id
    new_gid = (Process.groups - [Process.gid]).first
    raise "Unable to find group id other than #{Process.gid} for current process, can't create test file with a different group id" unless new_gid
    chown nil, new_gid
    self
  end

  def hardlink_to?(target)
    stat.ino == target.stat.ino    
  end
end

Spec::Matchers.define :be_hardlink_to do |target|
  match { |source| source.hardlink_to? target }
end
