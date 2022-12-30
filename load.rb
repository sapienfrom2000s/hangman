require_relative 'gameplay.rb'
require 'yaml'

class Load

    def load(filename)
        game_data = YAML.load File.read("./save/#{filename}")
    end

    def intantiate
        game_data = load(gets.chomp)
        hangman = Gameplay.new
        hangman.meaning = game_data[:meaning]
        hangman.word = game_data[:word]
        hangman.guesses = game_data[:guesses]
        hangman.casket.word = game_data[:word_casket]
        hangman.attempt_index = game_data[:attempt_index]
        resume_play(hangman)
    end

    def resume_play(hangman)
        hangman.hint
        hangman.show_guesses
        hangman.play
    end
end