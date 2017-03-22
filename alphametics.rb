require 'pry'
class Alphametics
  def self.solve(str)
    self.new(str).run
  end
  attr_accessor :result
  def initialize(str)
    @equation_string = str
    @result = {}
    @digits = (0..9).to_a
  end
  def run
    letters = @equation_string.scan(/[A-Z]/).uniq
    possible_answers = @digits.permutation(letters.length).to_a
    possible_answers.each do |answer|
      guess = Hash[letters.zip(answer)]
      if check_math(guess)
        return guess
      end
    end
    return {}
  end
  # def run
  #   puts "**START**"
  #   current_guess = random_guess
  #   puts "GUESS = #{current_guess}"
  #   if try(current_guess)
  #     puts "HOLY CRAP!"
  #     return result
  #   else
  #     puts "hahaha nope"
  #     return {}
  #   end
  #   # letters.each do |letter|
  #   #   result[letter] = @digits.sample(3)
  #   # end
  #   puts "**END**"
  # end
  # def try(current_guess)
  #   if check_math(current_guess)
  #     result = current_guess
  #     return true
  #   end
  #   try(random_guess)
  # end
  # def random_guess
  #   letters = @equation_string.scan(/[A-Z]/).uniq # unique letters
  #   # usable_digits = @digits.sample(letters.length) # pull unique as many numbers as there are letters
  #   Hash[letters.zip(usable_digits)] # make it a hash
  # end
  def check_math(current_guess)
    sides = @equation_string.split("==")
    left_str = sides[0].strip
    right_str = sides[1].strip
    addends = left_str.split("+").map(&:strip).map { |letter| current_guess[letter]}
    binding.pry
    left = addends.reduce(&:+)
    right = current_guess[right_str]
    left == right
  end
end