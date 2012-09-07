# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mimeograph/version"

Gem::Specification.new do |s|
  s.name        = "mimeograph"
  s.version     = Mimeograph::VERSION
  s.authors     = ["David Vollbracht"]
  s.email       = ["david@flipstone.com"]
  s.homepage    = ""
  s.summary     = %q{Keep multiple dev stations in sync w/ rsync}
  s.description = %q{}

  s.rubyforge_project = "mimeograph"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
   s.add_development_dependency "rspec"
   s.add_development_dependency "rake"
end
