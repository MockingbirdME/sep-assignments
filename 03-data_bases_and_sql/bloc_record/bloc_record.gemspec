Gem::Specification.new do |s|
  s.name          = 'bloc_record'
  s.version       = '0.1.0'
  s.date          = '2017-01-19'
  s.summary       = 'BlocRecord ORM'
  s.description   = 'An ActiveRecord-esque ORM adaptor'
  s.authors       = 'Devon Henegar'
  s.email         = 'devon.henegar@gmail.com'
  s.files         = Dir['lib/**/*.rb']
  s.require_paths = ["lib"]
  s.homepage      =
    'http://rubygems.org/gems/bloc_record'
  s.license       = 'MIT'
  s.add_runtime_dependency 'sqlite3', '~> 1.3'
  s.add_runtime_dependency 'pg', '~> 0.19.0'
  s.add_runtime_dependency 'activesupport'
end
