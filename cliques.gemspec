
Gem::Specification.new do |spec|
  spec.name          = "cliques"
  spec.version       = "1.0.0"
  spec.authors       = ["manuel"]
  spec.email         = ["lopez.urbina.manuel@gmail.com"]
  spec.summary       = "Given a list of developer handles, find all the groups of “fully connected” developers."
  spec.description   = "Two given developers are considered connected if: (1) They follow each other in twitter. (2) They have a Github organization in common."
  spec.files         = Dir['lib/*', 'lib/*/*', 'services/*']

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'octokit', '~>4.0'
  spec.add_development_dependency 'twitter', '~>6'
  spec.add_development_dependency 'dotenv', '~>2'
  spec.add_development_dependency 'rgl'

end
