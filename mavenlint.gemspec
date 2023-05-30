# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'mavenlint'
  s.version     = '1.5.0'
  s.licenses    = ['MIT']
  s.summary     = 'Mavenlink Rubocop config'
  s.authors     = ['Mavenlnk']
  s.email       = ['ahuth@mavenlink.com']
  s.files       = Dir['rubocop.yml', 'lib/**/*.rb']
  s.homepage    = 'https://github.com/mavenlink/mavenlint'

  s.add_development_dependency 'rake', '~> 12'
  s.add_development_dependency 'rspec', '3.7.0'
  s.add_development_dependency 'rubocop', '1.31'

  s.required_ruby_version = '>= 2.7.5'
end
