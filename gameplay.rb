require_relative 'word.rb'
require_relative 'casket.rb'

require 'colorize'

class Gameplay 
  attr_accessor :guesses, :word, :meaning

  def initialize
    @guesses = []
    obj = Word.new
    @word = obj.word
    begin
        @meaning = obj.meaning 
    rescue => exception
        initialize
    end
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

  def hint
    puts meaning
  end

  def welcome
    print "Welcome to a variation of Hangman\nNote: 20-30% of time, it fails to fetch the
     meaning, so rerun in that case\n "
  end

  def instruction
    puts 'You have 10 guesses to determine the word'
  end

  def update_guesses(char)
    word.include?(char) ? guesses.push(char.green) : guesses.push(char.red)
  end

  def show_guesses
    guesses.each { |guess| print guess }
    puts
  end

  def play
    obj2 = Casket.new
    obj2.casket(word)

    (1..10).each do |index|
      puts "Attempt #{index}"
      guessed_char = input
      update_guesses(guessed_char)
      show_guesses
      obj2.update_casket(word, guessed_char)
      if obj2.word_casket.join == word
        puts 'You did it'
        break
      end
    end
    puts "Better luck next time, the word was #{word}" if obj2.word_casket.join != word
  end
end
