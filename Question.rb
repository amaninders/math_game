class Question

	attr_reader :sum

	def initialize
		@num1 = rand(1..20)
		@num2 = rand(1..20)
		@sum  = @num1 + @num2
	end
	
	def ask
		"What does #{@num1} plus #{@num2} equals? "
	end
	
end