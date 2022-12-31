require_relative 'word.rb'
require_relative 'casket.rb'
require_relative 'save.rb'
require_relative 'inaugration.rb'

require 'colorize'

class Gameplay 
  attr_writer :guesses, :word, :meaning, :attempt_index
  attr_accessor :casket

  include Inaugration

  def initialize
    @guesses = []
    @attempt_index = 1
    obj = Word.new
    @word = obj.word
    @meaning = obj.meaning
    @casket = Casket.new(@word)
    @casket.display
  end

  def input
    while true
      puts 'Enter a char'
      inp = gets.chomp
      return inp if valid(inp)
      check_for_save_request(inp)
    end
  end

  def repeat?(character)
    if @guesses.any? { |char| char.uncolorize == character }
      puts "You've already guessed #{character}, try something else"
      true
    end
  end

  def valid(input)
    if input.match(/^[a-z]$/) && !repeat?(input)
      true
    else
      puts 'Enter valid input'
    end
  end

  def check_for_save_request(input)
    return unless input == "save"
    Save.new(@word, @meaning, @guesses, @attempt_index, @casket.word)
  end

  def hint
    puts @meaning
  end

  def update_guesses(char)
    @word.include?(char) ? @guesses.push(char.green) : @guesses.push(char.red)
  end

  def show_guesses
    @guesses.each { |guess| print guess }
    puts
  end

  def play
    (@attempt_index..10).each do |index|
      guessed_char = input
      puts "Attempt #{index}"
      update_attempt_index(index)
      update_guesses(guessed_char)
      show_guesses
      @casket.update(@word, guessed_char)
      break if win?
    end
    puts "Better luck next time, the word was #{@word}" if @casket.word.join != @word
  end

  def update_attempt_index(index)
    @attempt_index = index
  end

  def win?
    if @casket.word.join == @word
      puts 'You did it'
      return true
    end
    false
  end
end
