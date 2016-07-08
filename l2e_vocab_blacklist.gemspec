Gem::Specification.new do |s|
  s.name        = 'l2e_vocab_blacklist'
  s.version     = '1.2.4'
  s.date        = '2015-08-13'
  s.summary     = "L2E Vocab Blacklist"
  s.description = "Detect words and partial-words that shouldn't be used on Learn2Earn's website"
  s.authors     = ["Greg Sherrid", "Learn2Earn"]
  s.email       = 'greg@learn2earn.org'
  s.files       = Dir["{lib}/**/*.rb", "{lib}/**/*.txt", "{lib}/**/*.csv", "bin/*", "LICENSE", "*.md"]
  s.homepage    = 'https://github.com/gregsherrid/l2e_vocab_blacklist'
  s.license     = 'All rights reserved, for now'
end