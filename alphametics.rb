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
  def check_math(current_guess)
    translated_equation = @equation_string.gsub(/[A-Z]/, current_guess)
    return false unless valid_numbers?(translated_equation)
    sides = translated_equation.split("==")
    eval(sides[0]) == sides[1].to_i
  end
  
  def valid_numbers?(translated_equation)
    translated_equation.scan(/\d+/).each do |number|
      return false if number.to_i.to_s != number
    end
  end

end