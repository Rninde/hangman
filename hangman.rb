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
		@secret = @dictionary.sample.downcase.split("")

	end

	def new_board
		@board = []
		(@secret.length).times {@board << "_"}

	end

	def show
		puts "#{@board.join(" ")}   missed: #{@missed.join(" ")} misses left: #{@chances}"
	end

	def check
		if @secret.include?(@guess)
			@secret.each_index {|index| @board[index] = @guess if @secret[index] == @guess}
		else 
			@missed << @guess
			@chances -= 1
		end
		@win_condition = true if @board == @secret
	end

	def save
		@saved_data = [@missed.join(""), @chances, @board.join(""), @secret.join("")]
		File.open("save.txt", "w") do |f|
			@saved_data.each_index do |i|
				f.puts @saved_data[i]
			end
		end
	end

	def load
		@load_data = File.open("save.txt").readlines
		@missed = @load_data[0].split("")
		@chances = @load_data[1].to_i
		@board = @load_data[2].split("")
		@secret = @load_data[3].split("")
	end

	def play
		select
		new_board
		@missed = []
		@chances = 6
		puts "load game? y or n"
		load_game = gets.chomp
		load if load_game == "y"
		while (@win_condition == false) && (@chances > 0)
			show
			puts "Please select a letter or select 0 to save"
			@guess = gets.chomp.downcase
			@array = ("a".."z").to_a
			@array << "0"
			if @guess.length != 1 || !@array.include?(@guess) || @missed.include?(@guess) || @board.include?(@guess)
				puts "Invalid. Try again"
				redo
			end
			if @guess == "0"
				save
				break
			else
				check
			end
		end
		show
		puts @win_condition ? "Winner!" : "You lose."
	end
end

a = Hangman.new
a.play
