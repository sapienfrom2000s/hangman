require_relative 'word.rb'
require_relative 'casket.rb'
require_relative 'save.rb'
require_relative 'header.rb'

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
    begin
        @meaning = obj.meaning 
    rescue => exception
        initialize
    end
    @casket = Casket.new(@word)
    @casket.display
  end

  def input
    while true
      puts 'Enter a char'
      inp = gets.chomp
      return inp if valid(inp)
      save?(inp)
    end
  end

  def repeat?(character)
    if @guesses.any? { |char| char.uncolorize == character }
      puts "You've already guessed #{character}, try something else"
      true
    end
  end

  def valid(inp)
    if inp.match(/^[a-z]$/) && !repeat?(inp)
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
    Save.new(gets.chomp, @word, @meaning, @guesses, @attempt_index, @casket.word)
    exit
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
