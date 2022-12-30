
class Casket
    attr_accessor :word
  
    def initialize(word)
      @word = []
      form(word)
    end
  
    def form(word)
      @word = word.split('').map { |_chars| '_' }
    end
  
    def update(secret_word, char)
      secret_word.split('').each_index do |index|
        @word[index] = char if secret_word[index] == char
      end
      display
    end
  
    def display
      word.each { |char| print char }
      puts
    end
end
  