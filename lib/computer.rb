# frozen-string-literal: true

# logic for the computer that comes up with the word the player has to guess
class Computer
  WORDS = File.foreach('dictionary.txt').map { |line| line.chomp.downcase }.freeze

  def initialize(max_word_length = 12, min_word_length = 5)
    @max_length = max_word_length
    @min_length = min_word_length
  end

  def select_word
    legal_words = WORDS.select { |word| @min_length <= word.length && @max_length >= word.length }
    legal_words.sample
  end
end
