
class Casket
    attr_accessor :word_casket
  
    def initialize
      @word_casket = []
    end
  
    def casket(word)
      @word_casket = word.split('').map { |_chars| '_' }
      display_casket
    end
  
    def update_casket(word, char)
      word_casket.each_index do |index|
        @word_casket[index] = char if word[index] == char
      end
      display_casket
    end
  
    def display_casket
      word_casket.each { |char| print char }
      puts
    end
  
end
  