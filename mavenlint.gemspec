Gem::Specification.new do |s|
  s.name        = "mavenlint"
  s.version     = "1.1.1"
  s.licenses    = ["MIT"]
  s.summary     = "Mavenlink Rubocop config"
  s.authors     = ["Mavenlnk"]
  s.email       = ["ahuth@mavenlink.com"]
  s.files       = ["rubocop.yml", "lib/**/*.rb"]
  s.homepage    = "https://github.com/mavenlink/mavenlint"

  s.add_development_dependency "rake", '~> 12'
  s.add_development_dependency "rspec", "3.7.0"
  s.add_development_dependency "rubocop", "~> 0.49"
end
