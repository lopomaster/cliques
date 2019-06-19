
Gem::Specification.new do |spec|
  spec.name          = "cliques"
  spec.version       = Cliques::VERSION
  spec.authors       = ["manuel"]
  spec.email         = ["mlopez.urbina@atsistemas.com"]

  spec.summary       = "Write a short summary, because RubyGems requires one."
  spec.description   = "Write a longer description or delete this line."
  spec.files         = Dir['lib/*', 'lib/*/*', 'services/*']

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency 'pry'
  spec.add_runtime_dependency 'octokit', '~>4.0'
  spec.add_runtime_dependency 'twitter', '~>6'
  spec.add_runtime_dependency 'dotenv', '~>2'
  spec.add_runtime_dependency 'rgl'

end
