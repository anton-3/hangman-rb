# frozen-string-literal: true

require_relative 'saveable'
require_relative 'game'
require_relative 'player'

inp = 'y'
while inp == 'y'
  print "\nPress ENTER to play, or type \"load\" to load a saved game: "
  game = gets.chomp.downcase == 'load' ? Game.load : Game.new
  break if game.nil?

  game.play
  print 'Press y to play again: '
  inp = gets[0].downcase
end
