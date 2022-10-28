# frozen_string_literal: true

class Word
  attr_accessor :word

  def fetch_words
    words = []

    File.readlines('words.txt').each { |word| words.push(word.chomp) }
    words
  end

  def get_a_word
    words = fetch_words
    while word.nil?
      @word = words.sample
      @word = nil unless valid?(word)
    end
    word
  end

  def valid?(word)
    true if word.length >= 5 && word.length <= 12
  end
end

require 'open-uri'
require 'json'
require 'colorize'
require 'pry-byebug'

class Meaning < Word
  attr_accessor :meaning

  def meaning
    data = URI.open("https://api.dictionaryapi.dev/api/v2/entries/en/#{get_a_word}").read
    parsed_data = JSON.parse(data)
    parsed_data[0]['meanings'][0]['definitions'][0]['definition']
  end
end

class Gameplay < Meaning
  attr_accessor :guesses, :word_casket

  def initialize
    @guesses = []
    @word_casket = []
  end

  def input
    inp = get_char
    if repeat?(inp)
      puts "You've already guessed #{inp}, try something else"
      inp = get_char
    end
    inp
  end

  def repeat?(character)
    true if guesses.any? { |char| char.uncolorize == character }
  end

  def get_char
    puts 'Enter a character'
    char = gets.chomp
    if char.match(/[a-z]/) && char.length == 1
      char
    else
      puts 'Enter a valid input'
      get_char
    end
  end

  def welcome
    print "Welcome to a variation of Hangman\nNote: 20-30% of time, it fails to fetch the
     meaning, so rerun in that case\n "
  end

  def hint
    dictionary = Meaning.new
    begin
      puts "Hint: #{dictionary.meaning}"
    rescue StandardError
      retry
    end
    dictionary.word
  end

  def instruction
    puts 'You have 10 guesses to determine the word'
  end

  def casket
    @word_casket = @word.split('').map { |_chars| '_' }
    display_casket
  end

  def update_guesses(char)
    # binding.pry
    word.include?(char) ? guesses.push(char.green) : guesses.push(char.red)
  end

  def show_guesses
    guesses.each { |guess| print guess }
    puts
  end

  def update_casket(char)
    word_casket.each_index do |index|
      word_casket[index] = char if word[index] == char
    end
    display_casket
  end

  def display_casket
    word_casket.each { |char| print char }
    puts
  end

  def play(word)
    (1..10).each do |index|
      puts "Attempt #{index}"
      guessed_char = input
      update_guesses(guessed_char)
      show_guesses
      update_casket(guessed_char)
      if word_casket.join == word
        puts 'You did it'
        break
      end
    end
    puts "Better luck next time, the word was #{word}" if word_casket.join != word
  end
end

hangman = Gameplay.new
hangman.welcome
hangman.word = hangman.hint
hangman.casket
hangman.instruction
hangman.play(hangman.word)
