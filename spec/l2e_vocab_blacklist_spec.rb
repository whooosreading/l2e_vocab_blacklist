require 'rack/test'
require 'l2e_vocab_blacklist'

RSpec.configure do |config|
	config.expect_with :rspec do |c|
		c.syntax = [:should, :expect]
	end

	config.color = true
	config.tty = true
	config.formatter = :documentation # :progress, :html, :textmate
end

describe VocabBlacklist do
	describe "| Basics" do
		it "| Is not on blacklist" do
			VocabBlacklist.blacklisted?("pigeon").should == false
		end

		it "| Is on blacklist" do
			VocabBlacklist.blacklisted?("marijuana").should == true
		end

		it "| Case insensitive" do
			VocabBlacklist.blacklisted?("MariJuana").should == true
		end

		it "| Ignore punctuation" do
			VocabBlacklist.blacklisted?("mari.juana!").should == true
		end

		it "| Don't ignore asterisk" do
			VocabBlacklist.blacklisted?("sh*t").should == true
			VocabBlacklist.blacklisted?("sht").should == false
		end
	end

	describe "| Only full words" do
		it "| Word in full blacklisted" do
			VocabBlacklist.blacklisted?("anal").should == true
		end
		it "| Word in a sentence, blacklisted" do
			VocabBlacklist.blacklisted?("i think he's anal, right?").should == true
		end
		it "| Word within a word, ok" do
			VocabBlacklist.blacklisted?("analyze").should == false
		end
	end

	describe "| Greedy dirty word" do
		it "| Word on own" do
			VocabBlacklist.blacklisted?("fuck").should == true
		end
		it "| Word within word also blacklisted" do
			VocabBlacklist.blacklisted?("treefucker").should == true
		end
	end

	it "| Banned phrases" do
		VocabBlacklist.blacklisted?("Fifty Shades of Grey").should == true
	end

	describe "| Word subsitution" do
		it "| Full word" do
			str = VocabBlacklist.censor("I analyzed the artist's use of anal sex.")
			str.should == "I analyzed the artist's use of **** ****."
		end

		it "| Greedy dirty word" do
			str = VocabBlacklist.censor("We thought that was a BITCHING presentation.")
			str.should == "We thought that was a **** presentation."
		end

		it "| Phrases" do
			str = VocabBlacklist.censor("We prefer children don't read 50 Shades of Gray.")
			str.should == "We prefer children don't read ****."
		end

		it "| Alternate subsitution" do
			str = VocabBlacklist.censor("Need that cocaine!", "REDACTED")
			str.should == "Need that REDACTED!"
		end
	end

end