require 'yaml'

class Save

    def initialize(filename, word, meaning, guesses, attempt_index, casket)
        game_data = { filename:filename, word: word, meaning: meaning, guesses: guesses, attempt_index: attempt_index,
                    casket:casket }
        File.open("./save/#{filename + ".yml"}", "w") { |file| file.write(game_data.to_yaml) }
    end
end