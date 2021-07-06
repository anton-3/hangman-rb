# frozen-string-literal: true

require 'yaml'

# module for saving and loading games
module Saveable
  DIR_NAME = 'saves'

  # handles terminal input for saving a game
  def save(game)
    inp = 'y'
    name = nil
    loop do
      print 'What would you like to name the save file? '
      name = gets.chomp
      if Game.saved_games.include?(name)
        print 'That file already exists. Overwrite it? (y/n) '
        inp = gets[0].downcase
      end
      break if inp == 'y'
    end
    save_file(game, name)
  end

  def load
    names = saved_games
    if names.empty?
      print 'No games to load! Start a new game? (y/n) '
      gets[0].downcase == 'y' ? new : nil
    end

    puts "\nSaved games:"
    names.each_with_index { |name, index| puts "#{index + 1}: #{name}" }
    loop do
      print "\nWhich game do you want to load? (\"exit\" to cancel) "
      inp = gets.chomp
      index = inp.to_i - 1
      return nil if inp == 'exit'
      return load_file(names[index]) if index < names.length && index >= 0

      print 'Invalid input!'
    end
  end

  def saved_games
    filenames = Dir["#{DIR_NAME}/*"]
    filenames.map { |filename| filename[(DIR_NAME.length + 1)...(filename.index('.'))] }
  end

  private

  # saves a Game object to a yaml file
  def save_file(game, name)
    Dir.mkdir(DIR_NAME) unless Dir.exist?(DIR_NAME)
    filename = "#{DIR_NAME}/#{name}.yaml"
    File.open(filename, 'w') { |file| file.write(YAML.dump(game)) }
  end

  # loads a Game object from a yaml file
  def load_file(name)
    filename = "#{DIR_NAME}/#{name}.yaml"
    game = YAML.load_file(filename)
    File.delete(filename)
    game
  end
end
