module DiffFileSupport
  def diff_path
    cwd.join "mimeograph.diff"
  end

  def diff_contents
    File.read diff_path
  end

  def setup_diff_contents(content)
    File.open diff_path, 'w' do |diff|
      diff.puts content
    end
  end
end

RSpec.configure do |c|
  c.include DiffFileSupport
end
