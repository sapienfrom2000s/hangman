require_relative 'gameplay.rb'
require_relative 'load.rb'

class Choice 
    def newgame_or_loadgame

      input = get_a_valid_input
  
      case input
      when '1'
        new_game
      when '2'
        load_game
      end
    end

    def new_game
      hangman = Gameplay.new
      hangman.hint
      hangman.play
    end

    def load_game
      Dir.entries('./save').each{|file| puts file}
      puts "Enter the name of the file which you want to load"
      game = Load.new
      game.intantiate
    end

    def get_a_valid_input
        input = gets.chomp
        return input if input == '1' || input == '2'
        puts 'Press 1 to play a new game and 2 to load a saved game'
        get_a_valid_input
    end
end