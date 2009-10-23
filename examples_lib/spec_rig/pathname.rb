require 'pathname'

Pathname.class_eval do
  def create(content = "")
    self.parent.mkpath
    File.open(self, 'w') { |io| io << content }
    self
  end
end
