class Input_Manager

    def initialize(game_instance)
        @hangman = game_instance
    end

    def get_input
        while true
          puts 'Enter a char'
          @input = gets.chomp
          return @input if valid
          check_for_save_request
        end
    end

    def valid
        if @input.match(/^[a-z]$/) && !repeat?
          true
        else
          puts 'Enter valid input'
        end
    end

    def check_for_save_request
        return unless @input == "save"
        Save.new(@hangman.word, @hangman.meaning, @hangman.guesses, @hangman.attempt_index, @hangman.casket.word)
    end

    def repeat?(character = @input)
        if @hangman.guesses.any? { |char| char.uncolorize == character }
          puts "You've already guessed #{character}, try something else"
          true
        end
    end

end