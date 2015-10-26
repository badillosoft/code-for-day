# Alan Badillo Salas
# @badillo.soft | badillo.soft@hotmail.com
# Octubre 2015

def get_dim
	print "Ingresa n m :> "
	aux = gets.chomp.split(' ')

	if aux.size == 1
		return aux[0].to_i, aux[0].to_i
	end

	n, m = aux[0].to_i, aux[1].to_i
	
	return n, m
end

def get_mat(n, m)
	mat = []

	(0...n).each do |i|
		vec = []
		(0...m).each do |j|
			print "(#{i}, #{j}) :> "
			vec << gets.to_f
		end
		mat << vec
		puts
	end
	
	return mat
end

def get_vec
	vec = []
	
	aux = gets.chomp.split(' ')
	aux.each do |x|
		vec << x.to_f
	end
	
	return vec
end

class Matrix
	def self.read
		n, m = get_dim()
		mat = get_mat(n, m)
		
		return Matrix.new(mat)
	end
	
	def self.read_vec_mode
		print "n :> "
		n = gets.to_f
		
		mat = []
		
		(0...n).each do |i|
			print "#{i} :> "
			mat << get_vec
		end
		
		return Matrix.new(mat)
	end
	
	def self.make(n, m = nil, d = 0)
		m = n if m.nil?
	
		mat = []
		
		(0..n).each do |i|
			vec = []
			(0..m).each do |j|
				vec << d
			end
			mat << vec
		end
		
		return Matrix.new(mat)
	end
	
	def self.sign(i, j)
		(i + j) % 2 == 0 ? 1 : -1
	end
	
	def initialize(mat = [])
		@mat = mat
		@n = mat.size
		@m = mat[0].nil? ? 1 : mat[0].size
	end
	
	def clone
		mat = []
		(0...@n).each do |i|
			vec = []
			(0...@m).each do |j|
				vec << @mat[i][j]
			end
			mat << vec
		end
		
		return Matrix.new(mat)
	end
	
	def n; @n end
	def m; @m end
	
	def raw; @mat end
	
	def each
		@mat.each do |vec|
			yield vec
		end
	end
	
	def iterate
		(0...@n).each do |i|
			(0...@m).each do |j|
				yield @mat[i][j], i, j
			end
		end
	end
	
	def replace_col!(j, vec)
		(0...@n).each do |i|
			(0...@m).each do |jj|
				@mat[i, j] = vec[i] if j == jj
			end
		end
	end
	
	def replace_row!(i, vec)
		@mat[i] = vec
	end
	
	def replace_col(j, vec)
		mat = clone
	
		mat.replace_col! j, vec
		
		return mat
	end
	
	def replace_row(i, vec)
		mat.clone
	
		mat.replace_row! i, vec
		
		return mat
	end

	def minor(i, j)
		mat = []
		
		(0...@n).each do |ii|
			if i != ii
				vec = []
				(0...@m).each do |jj|
					vec << @mat[ii][jj] if j != jj
				end
				
				mat << vec
			end
		end
		
		return Matrix.new(mat)
	end
	
	def sign(i, j)
		Matrix.sign i, j
	end
	
	def determinant
		if @n != @m
			return nil
		end
		
		if @n == 1
			return self[0, 0]
		end
	
		if @n == 2
			return self[0, 0] * self[1, 1] - self[0, 1] * self[1, 0]
		end
	
		vec = @mat[0]
		
		s = 0.0
		
		(0...@n).each do |j|
			sub = minor(0, j)
			s += sub.determinant * vec[j] * sign(0, j)
		end
		
		return s
	end
	
	def pdeterminant
		if @n != @m
			return "!"
		end
		
		if @n == 1
			return self[0, 0] >= 0 ? "#{self[0, 0]}" : "(#{self[0, 0]})"
		end
	
		if @n == 2
			a = self[0, 0] >= 0 ? "#{self[0, 0]}" : "(#{self[0, 0]})"
			b = self[0, 1] >= 0 ? "#{self[0, 1]}" : "(#{self[0, 1]})"
			c = self[1, 0] >= 0 ? "#{self[1, 0]}" : "(#{self[1, 0]})"
			d = self[1, 1] >= 0 ? "#{self[1, 1]}" : "(#{self[1, 1]})"
		
			return "#{a} * #{d} - #{c} * #{b}"
		end
	
		vec = @mat[0]
		
		s = ""
		
		(0...@n).each do |j|
			sub = minor(0, j)
			s += "#{vec[j] * sign(0, j)} * (#{sub.pdeterminant}) "
		end
		
		return s[0...(s.size - 1)]
	end
	
	def rdeterminant
		if @n != @m
			return "!"
		end
		
		if @n == 1
			return self[0, 0] >= 0 ? "#{self[0, 0]}" : "(#{self[0, 0]})"
		end
	
		if @n == 2
			a = self[0, 0] >= 0 ? "#{self[0, 0]}" : "(#{self[0, 0]})"
			b = self[0, 1] >= 0 ? "#{self[0, 1]}" : "(#{self[0, 1]})"
			c = self[1, 0] >= 0 ? "#{self[1, 0]}" : "(#{self[1, 0]})"
			d = self[1, 1] >= 0 ? "#{self[1, 1]}" : "(#{self[1, 1]})"
		
			return "#{a} * #{d} - #{c} * #{b}"
		end
	
		vec = @mat[0]
		
		s = ""
		
		(0...@n).each do |j|
			sub = minor(0, j)
			s += "#{vec[j] * sign(0, j)} *\n#{sub}"
			s += "-> #{sub.pdeterminant} = #{sub.determinant}\n"
		end
		
		return s
	end
	
	def to_s
		s = ""
		@mat.each do |vec|
			s += "|"
			vec.each do |x|
				s += "#{x}\t"
			end
			s += "|\n"
		end
		return s
	end
	
	def [](i, j); @mat[i][j] end
	
	def []=(i, j, value); @mat[i][j] = value end
	
	def *(other)
		if other.instance_of? Matrix
			return nil
		end
		
		mat = clone
		
		iterate do |x, i, j|
			mat[i, j] = x * other
		end
		
		return mat
	end
end