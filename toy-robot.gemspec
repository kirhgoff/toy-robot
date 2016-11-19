# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "toy-robot"
  spec.version       = '1.0'
  spec.authors       = ["Kirill Lastovirya"]
  spec.email         = ["kirill.lastovirya@gmail.com"]
  spec.summary       = %q{Toy robot}
  spec.description   = %q{Toy robot that could be commanded to walk around the board}
  spec.homepage      = "https://github.com/kirhgoff/toy-robot"
  spec.license       = "LGPL v3.0"

  spec.files         = ['lib/model.rb', 'lib/commands.rb', 'lib/toy-robot.rb']
  spec.executables   = ['bin/toy-robot']
  spec.test_files    = ['tests/test_model.rb', 'tests/test_commands.rb']
  spec.require_paths = ["lib"]
end