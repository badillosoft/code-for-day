# Alan Badillo Salas
# @badillo.soft | badillo.soft@hotmail.com
# Octubre 2015

require_relative 'mat'

mat = Matrix.read_vec_mode

print "sol :> "

sol = get_vec

puts

puts "Matriz General"
puts mat

puts

puts "Determinante General: "
puts mat.rdeterminant
dg = mat.determinant
puts "D = #{dg}"

puts

puts "=" * 40

puts

(0...mat.m).each do |j|
	mat_aux = mat.replace_col(j, sol)
	
	puts "Matriz X#{j + 1}"
	puts mat_aux
	
	puts

	puts "Determinante #{j + 1}: "
	puts mat_aux.rdeterminant
	d = mat_aux.determinant
	puts "D#{j + 1} = #{d}"
	
	puts
	
	puts "| X#{j + 1} = #{d / dg} |"
	
	puts
	
	puts "=" * 40

	puts
end
