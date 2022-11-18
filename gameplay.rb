require_relative 'word.rb'
require_relative 'casket.rb'
require_relative 'save.rb'

require 'colorize'

class Gameplay 
  attr_accessor :guesses, :word, :meaning, :attempt_index, :casket

  def initialize
    @guesses = []
    @attempt_index = 1
    obj = Word.new
    @word = obj.word
    begin
        @meaning = obj.meaning 
    rescue => exception
        initialize
    end
  end

  def input
    while true
      puts 'Enter a char'
      inp = gets.chomp
      return inp if valid(inp) && !repeat?(inp)
      save?(inp)
    end

  end

  def repeat?(character)
    if guesses.any? { |char| char.uncolorize == character }
      puts "You've already guessed #{character}, try something else"
      true
    end
  end

  def valid(inp)
    if inp.match(/[a-z]/) && inp.length == 1
      true
    else
      puts 'Enter valid input'
    end
  end

  def save?(inp)
    save if inp == "save"
  end

  /saves the game and exits the program/
  def save
    puts "Enter a name identifier to save your game"
    Save.new(gets.chomp, word, meaning, guesses, attempt_index, casket)
    exit
  end

  def hint
    puts meaning
  end

  def welcome
    print "Welcome to a variation of Hangman\nNote: 20-30% of time, it fails to fetch the
     meaning, so rerun in that case\n "
  end

  def instruction
    puts 'You have 10 guesses to determine the word'
    puts 'Enter save at any point to save the game'
  end

  def update_guesses(char)
    word.include?(char) ? guesses.push(char.green) : guesses.push(char.red)
  end

  def show_guesses
    guesses.each { |guess| print guess }
    puts
  end

  def play
    obj = Casket.new(word)
    obj.word_casket = casket if caller[0][/`.*'/][1..-2] == "resume_play"
    obj.display

    (attempt_index..10).each do |index|
      @attempt_index = index
      puts "Attempt #{index}"
      guessed_char = input
      update_guesses(guessed_char)
      show_guesses
      @casket = obj.word_casket
      obj.update_casket(word, guessed_char)
      if obj.word_casket.join == word
        puts 'You did it'
        break
      end
    end
    puts "Better luck next time, the word was #{word}" if obj.word_casket.join != word
  end
end
