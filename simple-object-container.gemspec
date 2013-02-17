# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple-object-container/version'

Gem::Specification.new do |gem|
  gem.name          = "simple-object-container"
  gem.version       = SimpleObjectContainer::VERSION
  gem.authors       = ["Shinpei Maruyama"]
  gem.email         = ["shinpeim@gmail.com"]
  gem.description   = %q{simple object container for ruby}
  gem.summary       = %q{SimpleObjectContainer is a gem like Object::Container Perl module(http://search.cpan.org/~typester/Object-Container-0.14/lib/Object/Container.pm)
}
  gem.homepage      = "https://github.com/Shinpeim/SimpleObjectContainer"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec", "~> 2.12.0"
end
