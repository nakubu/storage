Gem::Specification.new do |s|
  s.name        = 'storage'
  s.version     = '0.0.4'
  s.date        = '2015-11-12'
  s.summary     = 'Trie Storage Example'
  s.description = 'Word Storage with Trie structure'
  s.authors     = ['Alexey Dunyushkin']
  s.email       = 'alexey.dunyushkin@dataart.com'
  s.files       = ['lib/storage.rb', 'lib/trie.rb']
  s.homepage    = 'http://github.com/nakubu/storage'
  s.license     = 'MIT'

  s.add_runtime_dependency 'zip', '~> 2.0'
  s.add_development_dependency 'minitest', '~> 5.0'
end
