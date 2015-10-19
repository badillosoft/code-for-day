require_relative 'index'

class Board
	attr_accessor :selected

	def initialize(rows, cols)
		@rows = rows
		@cols = cols
		@length = @rows * @cols
		@values = Array.new(@length, 0)
		@selected = Index.new(0, 0, self)
	end
	
	def copy(board)
		return false if board.rows != self.rows or board.cols != board.cols
	
		board.each do |value, index|
			self[index] = value 
		end
		
		return true
	end
	
	def clone
		new_board = Board.new(@rows, @cols)
		
		self.each do |value, index|
			new_board[index] = value
		end
		
		return new_board
	end
	
	def rows; @rows end
	def cols; @cols end
	
	def [](index)
		not index.nil? and index.valid? ?
			@values[index.row * @cols + index.col] : nil
	end
	
	def []=(index, value)
		if not index.nil? and index.valid?
			@values[index.row * @cols + index.col] = value
		end
	end
	
	def swap!(ini, fin)
		aux = self[ini]
		self[ini] = self[fin]
		self[fin] = aux
	end
	
	def swap(ini, fin)
		board = new Board(@rows, @cols)
		board.swap!(ini, fin)
		return board
	end
	
	def each
		index = Index.new(0, 0, self)
		begin
			yield self[index], index
		end while index.next!
	end
	
	def to_s
		header = "+" + ("-" * (3 * @cols - 1)) + "+\n"
		s = header
		self.each do |value, index|
			sub = case value
				when 0 then "\033[0;37m%2d\033[0m" % value 
				else "\033[0;34m%2d\033[0m" % value
			end
			
			if index == @selected
				sub = "\033[0;31m%2d\033[0m" % value
			end
		
			s += (index.on_left? ? "|" : "") + sub + 
				(index.on_right? ? "|\n" : " ")
		end
		s += header
		return s
	end
end