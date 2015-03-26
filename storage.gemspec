Gem::Specification.new do |s|
  s.name        = 'storage'
  s.version     = '0.0.3'
  s.date        = '2015-03-26'
  s.summary     = 'Trie Storage Example'
  s.description = 'Word Storage with Trie structure'
  s.authors     = ['Alexey Dunyushkin']
  s.email       = 'nakubu@gmail.com'
  s.files       = ['lib/storage.rb']
  s.homepage    = 'https://github.com/nakubu/storage'
  s.license     = 'MIT'

  s.add_runtime_dependency 'rubyzip', '>= 1.1.7'
  s.add_development_dependency 'minitest', '>= 5.5.1'
end
