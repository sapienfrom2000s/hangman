require 'yaml'

class Save

    def initialize(filename, word, meaning, guesses, attempt_index, word_casket)
        game_data = { filename:filename, word: word, meaning: meaning, guesses: guesses, attempt_index: attempt_index,
                    word_casket:word_casket }
        File.open("./save/#{filename + ".yml"}", "w") { |file| file.write(game_data.to_yaml) }
    end
end