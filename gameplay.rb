require_relative 'word.rb'
require_relative 'input_manager.rb'
require_relative 'casket.rb'
require_relative 'save.rb'

require 'colorize'

class Gameplay 
  attr_accessor :guesses, :word, :meaning, :attempt_index, :casket
  attr_reader :input_manager

  def initialize
    @guesses = []
    @attempt_index = 1
    obj = Word.new
    @word = obj.word
    @input_manager = Input_Manager.new(self)
    @meaning = obj.meaning
    @casket = Casket.new(@word)
    @casket.display
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
      guessed_char = input_manager.get_input
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
