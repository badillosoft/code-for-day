class Index
	def initialize(row = 0, col = 0, board = nil)
		@row = row
		@col = col
		@board = board
		@max_row = board.nil? ? 1 : board.rows - 1 
		@max_col = board.nil? ? 1 : board.cols - 1
	end
	
	def clone
		Index.new(@row, @col, @board)
	end
	
	def row; @row end
	def col; @col end
	
	def up
		row = @row > 0 ? @row - 1 : 0
		Index.new(row, @col, @board)
	end
	
	def down
		row = @row < @max_row ? @row + 1 : @max_row
		Index.new(row, @col, @board)
	end
	
	def left
		col = @col > 0 ? @col - 1 : 0
		Index.new(@row, col, @board)
	end
	
	def right
		col = @col < @max_col ? @col + 1 : @max_col
		Index.new(@row, col, @board)
	end
	
	def up!
		last_index = self.clone
		@row = @row > 0 ? @row - 1 : 0
		return last_index
	end
	
	def down!
		last_index = self.clone
		@row = @row < @max_row ? @row + 1 : @max_row
		return last_index
	end
	
	def left!
		last_index = self.clone
		@col = @col > 0 ? @col - 1 : 0
		return last_index
	end
	
	def right!
		last_index = self.clone
		@col = @col < @max_col ? @col + 1 : @max_col
		return last_index
	end
	
	def move!(direction = nil)
		#puts "Move: #{direction}" unless direction.nil?
		case direction
		when :up, :w then up!
		when :down, :s then down!
		when :left, :a then left!
		when :right, :d then right!
		else
			move! ([:up, :down, :right, :left].sort_by { rand }).first
		end
	end
	
	def up?; @row > 0 end
	
	def down?; @row < @max_row end
	
	def left?; @col > 0 end
	
	def right?; @col < @max_col end
	
	def on_up?; @row == 0 end
	
	def on_down?; @row == @max_row end
	
	def on_left?; @col == 0 end
	
	def on_right?; @col == @max_col end
	
	def next
		col = @col + 1
		
		if col > @max_col
			col = 0
			row = @row + 1
		end
		
		return Index.new(row, col, @board)
	end
	
	def next!
		@col += 1
		
		if @col > @max_col
			@col = 0
			@row += 1
		end
		
		return self.valid?
	end
	
	def boundary?
		return false if @board.nil?
	
		@row == 0 || @row == @max_row ||
		@col == 0 || @col == @max_col
	end
	
	def valid?
		return true if @board.nil?
	
		@row >= 0 && @row <= @max_row && @col >= 0 && @col <= @max_col
	end
	
	def to_s; "[#{@row}, #{@col}]" end
	
	def ==(other)
		row == other.row and col == other.col 
	end
end