L2E Vocab Blacklist
==================

Detect words and partial-words that shouldn't be used on Learn2Earn's website

To be expanded to allow for different classes of banned words so
administrators may loosen or expand restrictions, or so we can be more
permissive with older students.

Use:
```
gem 'wr_vocab_blacklist'
```

### To update and publish the gem

1. Merge pull requests, pull to local master
2. Run tests: `bundle exec rspec spec/wr_vocab_blacklist_spec.rb`
3. Increase the gem version and date in `wr_vocab_blacklist.gemspec`
4. Run `gem build wr_vocab_blacklist.gemspec`
5. Remove the old `.gem` file
6. Push the new gem with: `gem push wr_vocab_blacklist-X.X.X.gem` substituting in the gem version
  1. You may need to sign in on the CLI to push the gem. Talk to Greg about this.
7. Commit and push your changes