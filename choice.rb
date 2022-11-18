require_relative 'gameplay.rb'
require_relative 'load.rb'

class Choice 
    def newgame_or_loadgame
      puts 'Press 1 to play a new game and 2 to load a saved game'
      input = get_a_valid_input
  
      case input
      when '1'
        hangman = Gameplay.new
        hangman.welcome
        hangman.hint
        hangman.instruction
        hangman.play
  
      when '2'
        Dir.entries('./save').each{|file| puts file}
        puts "Enter the name name of file which you want to load"
        game = Load.new
        game.intantiate
      end
    end

    def get_a_valid_input
        input = gets.chomp
        if input == '1' || input == '2'
            return input
        else
            puts 'Enter valid input'
            get_a_valid_input
        end
    end
end