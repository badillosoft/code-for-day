require_relative 'board'

class Board2048 < Board
	def initialize()
		super(4, 4)
		@cells = []
		@last_cell = Index.new(0, 0, self)
	end
	
	def clone
		new_board = Board2048.new()
		
		new_board.copy(self)
		
		return new_board
	end
	
	def reset!
		(0..@length).each do |i|
			@values[i] = 0
		end
	end
	
	def reset
		board = clone
		board.reset!
	end
	
	def put!
		return self if full?
		value = Random.rand(1..10) <= 6 ? 2 : 4
		begin
			row = Random.rand(0...@rows)
			col = Random.rand(0...@cols)
			index = Index.new(row, col, self)
			if self[index] == 0
				self[index] = value
				@cells << index
				@last_cell = index
				break
			end
		end while true
		return self
	end
	
	def put
		board = self.clone
		board.put!
		return board
	end
	
	def full?
		@cells.length >= 16
	end
	
	def move_up!
		@cells.sort! do |a, b|
			a.row == b.row ? a.col - b.col : a.row - b.row
		end
		print_cells
		@cells.each do |index|
			abort = false
			puts "> #{index}"
			until index.on_up? or abort
				new_index = index.up
				if self[new_index] == 0
					swap!(new_index, index)
					puts "#{index} <-> #{new_index}"
					index.up!
				elsif  self[new_index] == self[index]
					self[new_index] *= 2
					self[index] = 0
					@cells.delete(index)
					puts "#{index} >-< #{new_index}"
					abort = true
				else
					abort = true
				end
			end
		end
		put!
		return self
	end
	
	def move_down!
		@cells.sort! do |a, b|
			a.row == b.row ? a.col - b.col : b.row - a.row
		end
		print_cells
		@cells.each do |index|
			abort = false
			puts "> #{index}"
			until index.on_down? or abort
				new_index = index.down
				if self[new_index] == 0
					swap!(new_index, index)
					puts "#{index} <-> #{new_index}"
					index.down!
				elsif  self[new_index] == self[index]
					self[new_index] *= 2
					self[index] = 0
					@cells.delete(index)
					puts "#{index} >-< #{new_index}"
					abort = true
				else
					abort = true
				end
			end
		end
		put!
		return self
	end
	
	def move_left!
		@cells.sort! do |a, b|
			a.col == b.col ? a.row - b.row : a.col - b.col
		end
		print_cells
		@cells.each do |index|
			abort = false
			puts "> #{index}"
			until index.on_left? or abort
				new_index = index.left
				if self[new_index] == 0
					swap!(new_index, index)
					puts "#{index} <-> #{new_index}"
					index.left!
				elsif  self[new_index] == self[index]
					self[new_index] *= 2
					self[index] = 0
					@cells.delete(index)
					puts "#{index} >-< #{new_index}"
					abort = true
				else
					abort = true
				end
			end
		end
		put!
		return self
	end
	
	def move_right!
		@cells.sort! do |a, b|
			a.col == b.col ? a.row - b.row : b.col - a.col
		end
		print_cells
		@cells.each do |index|
			abort = false
			puts "> #{index}"
			until index.on_right? or abort
				new_index = index.right
				if self[new_index] == 0
					swap!(new_index, index)
					puts "#{index} <-> #{new_index}"
					index.right!
				elsif  self[new_index] == self[index]
					self[new_index] *= 2
					self[index] = 0
					@cells.delete(index)
					puts "#{index} >-< #{new_index}"
					abort = true
				else
					abort = true
				end
			end
		end
		put!
		return self
	end
	
	def move!(direction = nil)
		puts "Move: #{direction}" unless direction.nil?
		case direction
		when :up then move_up!
		when :down then move_down!
		when :left then move_left!
		when :right then move_right!
		else
			move! ([:up, :down, :right, :left].sort_by { rand }).first
		end
		return self
	end
	
	def print_cells
		@cells.each do |index|
			puts index
		end
	end
	
	def to_s
		s = "+-------+\n"
		self.each do |value, index|
			sub = case value
				when 0 then "\033[0;37m#{value}\033[0m" 
				else "\033[0;34m#{value}\033[0m"
			end
			
			if index == @last_cell
				sub = "\033[0;31m#{value}\033[0m"
			end
		
			s += (index.on_left? ? "|" : "") + sub + 
				(index.on_right? ? "|\n" : " ")
		end
		s += "+-------+\n"
		return s
	end
end

board = Board2048.new

puts board

moves = 0
begin
	puts board.move!
	moves += 1
end until board.full? or moves >= 20

puts board
puts "\n"

#puts "\nTotal moves: #{moves}"