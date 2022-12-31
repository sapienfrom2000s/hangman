require 'yaml'

class Save

    def initialize(word, meaning, guesses, attempt_index, word_casket)
        puts "Enter a name identifier to save your game"
        filename = gets.chomp
        game_data = { filename:filename, word: word, meaning: meaning, guesses: guesses, attempt_index: attempt_index,
                    word_casket:word_casket }
        File.open("./save/#{filename + ".yml"}", "w") { |file| file.write(game_data.to_yaml) }
        exit
    end
end