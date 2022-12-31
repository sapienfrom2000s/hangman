require 'open-uri'
require 'json'

class Word
  attr_accessor :word, :meaning

  def initialize
    @word = get_a_word 
    begin
      @meaning = get_meaning(word) 
    rescue => exception
      initialize
  end
  end

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

  def get_meaning(word)
    data = URI.open("https://api.dictionaryapi.dev/api/v2/entries/en/#{word}").read
    parsed_data = JSON.parse(data)
    parsed_data[0]['meanings'][0]['definitions'][0]['definition']
  end

end
