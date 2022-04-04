Gem::Specification.new do |s|
  s.name        = 'wr_vocab_blacklist'
  s.version     = '0.0.1'
  s.date        = '2022-03-16'
  s.summary     = "Whooo's Reading Vocab Blacklist"
  s.description = "Detect words and partial-words that shouldn't be used on Whooo's Reading website"
  s.authors     = ["Greg Sherrid", "Gilles Ferone", "Kevin Schroeder", "Matt Schleifman", "Whooo's Reading by Learn2Earn"]
  s.email       = ['kevin@whooosreading.org', 'gilles@whooosreading.org', 'matt@whooosreading.org']
  s.files       = Dir["{lib}/**/*.rb", "{lib}/**/*.txt", "{lib}/**/*.csv", "bin/*", "LICENSE", "*.md"]
  s.homepage    = 'https://github.com/whooosreading/l2e_vocab_blacklist'
  s.license     = 'All rights reserved, for now'

  # s.add_runtime_dependency "activesupport-inflector"
  # s.add_runtime_dependency "i18n"
end