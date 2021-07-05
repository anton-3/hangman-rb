# frozen-string-literal: true

require_relative 'game'
require_relative 'player'
require_relative 'computer'

inp = 'y'
while inp == 'y'
  Game.new.play
  print 'Press y to play again: '
  inp = gets.chomp.downcase
end
