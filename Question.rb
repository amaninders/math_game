class Question
  attr_reader :num1, :num2, :sum

  def initialize()
    @num1 = rand(1..10)
    @num2 = rand(1..10)
  end

  def sum
    sum = @num1 + @num2
  end
end