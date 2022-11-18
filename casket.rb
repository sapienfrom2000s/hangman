
class Casket
    attr_accessor :word_casket
  
    def initialize(word)
      @word_casket = []
      form_casket(word)
    end
  
    def form_casket(word)
      @word_casket = word.split('').map { |_chars| '_' }
    end
  
    def update_casket(word, char)
      word_casket.each_index do |index|
        @word_casket[index] = char if word[index] == char
      end
      display
    end
  
    def display
      word_casket.each { |char| print char }
      puts
    end
  
end
  