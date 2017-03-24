class Alphametics
  attr_accessor :result
  
  def initialize(equation_string)
    @equation_string = equation_string
    @letters = @equation_string.scan(/[A-Z]/).uniq
    @permutations = (0..9).to_a.permutation(@letters.length)
  end
  
  def self.solve(equation_string)
    new(equation_string).run
  end

  def run
    @permutations.each do |permutation|
      translator = Hash[@letters.zip(permutation)]
      return translator if check_math(translator)
    end
    {}
  end
  
  def check_math(translator)
    @translated_equation = @equation_string.gsub(/[A-Z]/, translator)
    return false unless valid_numbers?
    sides = @translated_equation.split("==")
    eval(sides[0]) == sides[1].to_i
  end
  
  private
  
  def valid_numbers?
    @translated_equation.scan(/\d+/).each do |number|
      return false if number.to_i.to_s != number
    end
  end
end
