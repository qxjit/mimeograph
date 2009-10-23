require 'pathname'

Pathname.class_eval do
  def write(content)
    File.open(self, 'w') { |io| io << content }
  end
end
