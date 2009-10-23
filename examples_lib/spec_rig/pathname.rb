require 'pathname'

Pathname.class_eval do
  def write(content)
    self.parent.mkpath
    File.open(self, 'w') { |io| io << content }
  end
end
