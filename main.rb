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
    
    while word == nil
      @word = words.sample
      @word = nil unless valid?(word)
    end
    word
  end

  def valid?(word)
    true if word.length >= 5 && word.length <= 12
  end
end

list = Word.new
p list.get_a_word