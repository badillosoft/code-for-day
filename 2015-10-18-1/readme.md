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

* __exit__ - Quit the game
* __new__ - Reset the game
* __w__ - Move-Up the 0
* __s__ - Move-Down the 0
* __a__ - Move-Left the 0
* __d__ - Move-Right the 0
* __up / down / right / left__ - Move-X the selected position (the red cell)
* __swap a b c d__ - Move the (a, b) to (c, d)
* __put a__ - Put a number on the selected position (the red cell)
* __p__ - abbreviation of put
* __set a b value__ - Set value in (a, b) position
* __select a b__ - Select the (a, b) position (set the new selected position)
* __magnet__ - Change the magnet property of the selected cell,
	if the magnet is true the number associated swaps with
	the selected position, else the selected position is independient
* __suffle n__ - Apply n-moves in random direccion of the selected position 