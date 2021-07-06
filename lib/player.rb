# frozen-string-literal: true

# logic for the human player who has to guess the word
class Player
  ALPHABET = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z].freeze

  def initialize(game)
    @game = game
  end

  def make_guess
    guess = nil
    loop do
      print 'Guess a letter or type "save" to save the game: '
      guess = gets.chomp.downcase
      return 'save' if guess == 'save'
      break if ALPHABET.include?(guess) && !@game.all_guesses.include?(guess)

      puts 'Invalid input!'
    end
    guess
  end
end
