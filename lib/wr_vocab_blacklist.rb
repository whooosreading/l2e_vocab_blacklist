require 'active_support/inflector'
require 'csv'  

class VocabBlacklist

	# Returns true or false, check to see if the string is on the blacklist
	def self.blacklisted?(str, age = "0")
		# Sanitize string
		str = str.downcase.strip

		whitelisted_phrases = self.whitelist_matches(str)

		# Blacklist if any of the words 
		str.split(/[ -]/).each do |word|
			word = word.gsub(CONSIDER_REGEX, "")

			if check_full_words_csv(word, age)

				is_whitelisted = whitelisted_phrases.any? do |phrase|
					phrase.include?(word)
				end
				if !is_whitelisted
					return true
				end
			end
		end
		# For compound dirty words
		PHRASES.each do |bad_phrase|
			return true if str.include?(bad_phrase)
		end
		
		return GREEDY_WORDS.any? { |s| str.include?(s) }
	end

	def self.whitelist_matches(text)
		text = text.downcase.strip.gsub(CONSIDER_REGEX, "")
		WHITELIST.select do |whitelist_phrase|
			text.include?(whitelist_phrase)
		end

	end

	def self.censor(str, age = "0", replace_with = "*", keep_first_letter = false)
		PHRASES.each do |bad_phrase|
			# match number of characters for any replace_with that is 1 character
			if replace_with.length == 1 && keep_first_letter
				str.gsub!(/#{ bad_phrase }/i, bad_phrase[0])
			elsif replace_with.length == 1
				str.gsub!(/#{ bad_phrase }/i, replace_with * bad_phrase.length)
			else
				str.gsub!(/#{ bad_phrase }/i, replace_with)
			end
		end

		whitelisted_phrases = self.whitelist_matches(str)

		str.split(/ /).map do |working_word|
			working_word.split(/-/).map do |sub_working_word|
				word = sub_working_word.downcase.gsub(CONSIDER_REGEX, "")

				is_whitelisted = whitelisted_phrases.any? do |phrase|
					phrase.include?(word)
				end

				if !is_whitelisted
					if check_full_words_csv(word, age)
						# match number of characters for any replace_with that is 1 character
						if replace_with.length == 1 && keep_first_letter
							sub_working_word.gsub!(/#{ word }/i, word[0])
						elsif replace_with.length == 1
							sub_working_word.gsub!(/#{ word }/i, replace_with * word.length)
						else
							sub_working_word.gsub!(/#{ word }/i, replace_with)
						end
					end

					if GREEDY_WORDS.any? { |w| word.include?(w) }
						# match number of characters for any replace_with that is 1 character
						if replace_with.length == 1 && keep_first_letter
							sub_working_word = sub_working_word[0]
						elsif replace_with.length == 1
							sub_working_word = replace_with * sub_working_word.length
						else
							sub_working_word = replace_with
						end
					end
				end

				sub_working_word
			end.join("-")
		end.join(" ")
	end

	def self.file_to_normalized_words(file)
		CSV.parse(File.read(file)).map(&:first).reject { |s| s.to_s.strip.empty? }.map(&:downcase).map { |s| s.gsub(CONSIDER_REGEX, "") }
	end

	def self.words_with_expansions(words)
		words.map { |s| [s, s.pluralize, s.singularize] }.uniq.flatten
	end

	BLACKLIST_DIR = File.join(File.dirname(__FILE__), 'wr_vocab_blacklist/blacklists')
	CONSIDER_REGEX = /[^0-9a-z\* ]/i

	PHRASES = file_to_normalized_words("#{BLACKLIST_DIR}/full_words.csv").select { |w| w.split(" ").length > 1 }
	FULL_WORDS = file_to_normalized_words("#{BLACKLIST_DIR}/full_words.csv").reject { |w| w.split(" ").length > 1 }
	GREEDY_WORDS = words_with_expansions(file_to_normalized_words("#{BLACKLIST_DIR}/greedy_words.txt")).uniq.freeze
	WHITELIST = file_to_normalized_words("#{BLACKLIST_DIR}/whitelist.csv").uniq.freeze

	FULL_WORDS_CSV = CSV.parse(File.read("#{BLACKLIST_DIR}/full_words.csv"))

	private

		def self.check_full_words_csv(word, age)
			FULL_WORDS_CSV.each do |row|
				return true	 if row[1].to_i >= age.to_i && row[0].downcase == word.downcase
			end
			return false
		end

end