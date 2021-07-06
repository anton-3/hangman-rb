# frozen-string-literal: true

# game logic
class Game
  extend Saveable

  attr_reader :guesses

  WORDS = File.foreach('dictionary.txt').map { |line| line.chomp.downcase }.freeze
  MIN_LENGTH = 5
  MAX_LENGTH = 12

  def initialize(max_incorrect_guesses = 11)
    @max_incorrect_guesses = max_incorrect_guesses
    @player = Player.new(self)
    @wrong_guess_count = 0
    @guesses = { correct: [], incorrect: [] }
    @word = select_word
  end

  def play
    puts "\nTry to guess the computer's word!"
    puts "You lose if you guess incorrectly #{@max_incorrect_guesses} times."
    sleep 1
    display_turn
    game_loop
  end

  def all_guesses
    @guesses[:correct] + @guesses[:incorrect]
  end

  private

  def game_loop
    while @guesses[:incorrect].length < @max_incorrect_guesses
      guess = @player.make_guess
      handle_guess(guess)
      return if guess == 'save'

      display_turn
      if check_win?
        puts 'You win!'
        return
      end
    end
    puts 'You lose!'
    reveal_word
  end

  def display_turn
    turn_msg = "\n"
    letters.each do |letter|
      turn_msg += @guesses[:correct].include?(letter) ? "#{letter} " : '_ '
    end
    turn_msg += "\nIncorrect guesses (#{@guesses[:incorrect].length}): "
    @guesses[:incorrect].each do |guess|
      turn_msg += "#{guess.upcase} "
    end
    turn_msg += "\n\n"
    puts turn_msg
  end

  def select_word
    WORDS.select { |word| MIN_LENGTH <= word.length && MAX_LENGTH >= word.length }.sample
  end

  def handle_guess(guess)
    if guess == 'save'
      Game.save(self)
    else
      correctness = letters.include?(guess) ? :correct : :incorrect
      puts "#{correctness.to_s.capitalize}!"
      sleep 0.5
      @guesses[correctness] << guess
    end
  end

  def check_win?
    letters.uniq.sort == @guesses[:correct].sort
  end

  def letters
    @word.split('')
  end

  def reveal_word
    puts "The word was: #{@word}"
  end
end
