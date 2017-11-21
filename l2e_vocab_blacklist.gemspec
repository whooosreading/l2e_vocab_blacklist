Gem::Specification.new do |s|
  s.name        = 'l2e_vocab_blacklist'
  s.version     = '1.3.1'
  s.date        = '2017-08-13'
  s.summary     = "L2E Vocab Blacklist"
  s.description = "Detect words and partial-words that shouldn't be used on Learn2Earn Whooo's Reading website"
  s.authors     = ["Greg Sherrid", "Learn2Earn", "Whooo's Reading"]
  s.email       = 'greg@whooosreading.org'
  s.files       = Dir["{lib}/**/*.rb", "{lib}/**/*.txt", "{lib}/**/*.csv", "bin/*", "LICENSE", "*.md"]
  s.homepage    = 'https://github.com/whooosreading/l2e_vocab_blacklist'
  s.license     = 'All rights reserved, for now'
end