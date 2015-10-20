# Alan Badillo Salas
# @badillo.soft | badillo.soft@hotmail.com
# Octubre 2015

=begin

El siguiente programa crea un tablero de 4x4 para simular un puzzle
El programa imprime el tablero y espera un comando del usuario
Cada comando puede recibir atributos, por ejemplo
	Para crear un nuevo juego
	:> new
	Para salir
	:> exit
	Para ajustar el valor de 3 en la posición (1, 1)
	:> set 1 1 3
	Para intercambiar la posición (1, 1) con la (2, 2)
	:> swap 1 1 2 2
	Para cambiar el tamaño del tablero a 5x10
	:> new_size 5 10
	Para revolver el tablero 10 veces
	:> suffle 10
	Para seleccionar la posición (1, 1) del tablero
	:> select 1 1
	Para evitar que las piezas se muevan junto a la pieza seleccionada
	:> magnet 0
	:> m 0
	Para invertir el magnetismo de las piezas con la seleccionada
	:> magnet
	:> m
	Para poner el número 5 en la pieza seleccionada
	:> put 5
	:> p 5
	:> 5
	Para mover la pieza seleccionada arriba
	:> up
	:> w
	Para mover la pieza seleccionada abajo
	:> down
	:> s
	Para mover la pieza seleccionada a la izquierda
	:> left
	:> a
	Para mover la pieza seleccionada a la derecha
	:> right
	:> d
=end 

require_relative 'board'
require_relative 'core'

def reset(board)
	count = 1
	board.each do |x, index|
		board[index] = count
		count += 1
	end
	
	board.selected = Index.new(3, 3, board)
	board[board.selected] = 0  
end

def suffle(board, n)
	(0...n).each do |i|
		index = board.selected
		last_index = board.selected.move!
		board.swap! last_index, index
	end
end

board = Board.new(4, 4)

reset(board)
suffle(board, 10000)

magnet = true

begin
	system 'clear'
	
	puts board
	
	data = get_command
	
	case data.command
	when :new_size
		board = Board.new(data.a, data.b)
	when :new
		reset(board)
		suffle(board, 10000)
	when :suffle
		suffle(board, data.a)
	when :set
		index = Index.new(data.a, data.b) 
		board[index] = data.c
	when :put, :p
		index = board.selected
		board[index] = data.a
	when :swap
		ini = Index.new(data.a, data.b)
		fin = Index.new(data.c, data.d)
		board.swap! ini, fin
	when :select
		index = Index.new(data.a, data.b)
		board.selected = index
	when :magnet, :m
		magnet = data.a.nil? ? 
			(not magnet) : (data.a == 1 ? true : false)
	when :up, :w, :down, :s, :left, :a, :right, :d
		index = board.selected
		last_index = board.selected.move!(data.command)
		if magnet
			board.swap! last_index, index
		end
	else
		begin
			i = Integer(data.command.id2name)
			index = board.selected
			board[index] = i
		rescue
			puts "Command is not a number"
		end
	end
end until data.command == :exit