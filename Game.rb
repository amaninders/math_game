# require the modules
require './Question'
require './Player'

class Game
	
	@records = [
		{game:1, questions: 10, p1:0, p2:3},
		{game:2, questions: 10, p1:2, p2:3},
		{game:3, questions: 10, p1:1, p2:3},
	]

	@user_input = nil
	
	def self.greeting
		# Greet the user
		formatter = "\n%{banner} %{play} %{records} %{exit}\n"
		puts formatter % {
		  banner:  "######### Welcome #########\n",
		  play: 	 "1. Press P to play the Game\n",
		  records: "2. Press R to show records\n",
		  exit:    "3. Press E to exit\n"
		}
	end

	# Method to launch game, records or exit
	def self.launch

		# valid game actions
		actions = ['P', 'p', 'E', 'e', 'R', 'r']

		# prompt the user for input
		print "Press one of the keys to continue (P, R, or E): "

		begin
			# user input from CLI
			@user_input = gets.chomp
			# returns invalid input unless correct one provided
			puts "Invalid Input (Press P, R or E)" unless actions.include?(@user_input)
		end while actions.include?(@user_input) == false
		
		# action to perform on valid input
		case @user_input
			when 'P', 'p'
				self.start
			when 'R', 'r'
				self.records
			else
				self.end
		end		
	end 	

	# Method to start game
	def self.start
		
		current_game = {
			game: @records.length,
			questions: 0,
			p1: 0,
			p2: 0
		}
		
		begin
			
			questions = current_game[:questions]

			# set current player based on number of questions
			current_player = (questions % 2 == 0 ? '1' : '2')
			# set player key for updates
			player_key = "p#{current_player}"
			
			# ask question
			question = Question.new
			print "Player #{current_player}: " + question.ask

			# change number of questions 
			current_game[:questions] += 1

			# get answer and provide result
			answer = gets.chomp.to_i

			if answer == question.sum
				puts "Bingo!"
			else
				puts "Wrong!"
				current_game[player_key.to_sym] += 1
			end

			# display player scores after result
			puts "P1 #{current_game[:p1]}/3 vs P2 #{current_game[:p2]}/3"

		end while (current_game[:p1] < 3 && current_game[:p2] < 3)

		puts "\n ------ GAME OVER ------\n\n"

		@records.push(current_game)

		self.launch

	end

	# Method to end game
	def self.end
		puts "\nThanks for playing the game 👋👋👋\n\n"
	end

	# Method to display the records
	def self.records
		puts "\n######### Records #########\n\n"
		@records.each do |record|
				puts self.match_result record
		end	
		puts "\n###########################\n\n"

		self.launch
	end
	
	# Method to display the match result
	def self.match_result(obj)
		winner = obj[:p1] < obj[:p2] ? '1' : '2'
		key = "p#{winner}"
		score  = obj[key.to_sym];
		questions = obj[:questions]
		"Game #{obj[:game]} => Player #{winner} wins with a score of #{score}/3 after a round of #{questions} questions"
	end

end