Gem::Specification.new do |s|
  s.name        = "mavenlint"
  s.version     = "1.0.1"
  s.licenses    = ["MIT"]
  s.summary     = "Mavenlink Rubocop config"
  s.authors     = ["Mavenlnk"]
  s.files       = %w[
    rubocop.yml
    lib/rubocop-mavenlink.rb
    lib/rubocop/cop/mavenlink/fixjour_style_factories.rb
  ]
  s.homepage    = "https://github.com/mavenlink/mavenlint"

  s.require_paths = ["lib"]

  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", "~> 3.0"

  s.add_runtime_dependency "rubocop", "~> 0.47.1"
end
