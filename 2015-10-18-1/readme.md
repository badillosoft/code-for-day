## Puzzle Game on Ruby

This is a new game code for Ruby.

For test the game open a terminal and execute:

~~~bash
$ruby test_board.rb
~~~

New board and a internatl prompt open on the terminal
like this:

~~~bash
+-----------+
| 1  2  3  4|
| 5  6  7 10|
| 8  9 14 15|
| 0 11 12 13|
+-----------+
:> 
~~~

On the prompt you can write any of next commands:

* exit - Quit the game
* new - Reset the game
* w - Move-Up the 0
* s - Move-Down the 0
* a - Move-Left the 0
* d - Move-Right the 0
* up / down / right / left - Move-X the selected position (the red cell)
* swap a b c d - Move the (a, b) to (c, d)
* put a - Put a number on the selected position (the red cell)
* p - abbreviation of put
* set a b value - Set value in (a, b) position
* select a b - Select the (a, b) position (set the new selected position)
* magnet - Change the magnet property of the selected cell,
	if the magnet is true the number associated swaps with
	the selected position, else the selected position is independient
* suffle n - Apply n-moves in random direccion of the selected position 