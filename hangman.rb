class Hangman
	def initialize
		@dictionary = []
		File.open('5desk.txt').each do |line| 
			line.strip!
			@dictionary << line if line.length < 12 && line.length > 5
		end
		@win_condition = false
	end
	def select
		@secret = @dictionary.sample.split("")

	end

	def new_board
		@board = []
		(@secret.length).times {@board << "_"}

	end

	def show
		puts "#{@board.join(" ")}    missed: #{@missed.join(" ")} misses left: #{@chances}"
	end

	def check
		if @secret.include?(@guess)
			@secret.each_index {|index| @board[index] = @guess if @secret[index] == @guess}
		else 
			@missed << @guess
			@chances -= 1
		end
		win?
	end

	def win?
		@win_condition = true if @board == @secret
	end



	def play
		select
		new_board
		@missed = []
		@chances = 6
		while (@win_condition == false) && (@chances > 0)
			show
			puts "Please select a letter"
			@guess = gets.chomp.downcase
			check
		end
		show
		if @win_condition == true
			puts "Winner!"
		else
			puts "You lose."
		end
	end






attr_reader :dictionary, :secret, :board





end

a = Hangman.new
a.play
