# Alan Badillo Salas
# @badillo.soft | badillo.soft@hotmail.com
# Octubre 2015

class Observer
	def initialize
		@listeners = []
	end
	
	def add_listener(callbak)
		@listeners << callbak
	end
	
	def on_change(sender, name, value)
		if @listeners.length <= 0
			return
		end
	
		@listeners.each do |callbak|
		callbak.call(sender, name, value)
		end
	end
end

class Color
	def self.alfa(color)
		(color & 0xff000000) >> 24
	end
	
	def self.red(color)
		(color & 0x00ff0000) >> 16
	end
	
	def self.green(color)
		(color & 0x0000ff00) >> 8
	end
	
	def self.blue(color)
		color & 0x000000ff
	end
	
	def self.from_argb(a = 255, r = 0, g = 0, b = 0)
		(a << 24) + (r << 16) + (g << 8) + (b << 0)
	end
	
	def self.from_rgba(r = 0, g = 0, b = 0, a = 255)
		(a << 24) + (r << 16) + (g << 8) + (b << 0)
	end
	
	def self.middle(c1, c2)
		(Color.new(c1) + Color.new(c2)).value
	end
	
	def self.Red; Color.from_rgba(255) end
	def self.Green; Color.from_rgba(0, 255) end
	def self.Blue; Color.from_rgba(0, 0, 255) end
	
	attr_reader :alfa, :red, :green, :blue, :value
	
	def self.new_from_rgba(r = 0, g = 0, b = 0, a = 255)
		@alfa = [[a, 0].max, [a, 255].min].max
		@red = [[r, 0].max, [r, 255].min].max
		@green = [[g, 0].max, [g, 255].min].max
		@blue = [[b, 0].max, [b, 255].min].max
		
		@value = Color.from_argb(@alfa, @red, @green, @blue)
	end
	
	def self.new_from_argb(a = 255, r = 0, g = 0, b = 0)
		@alfa = [[a, 0].max, [a, 255].min].max
		@red = [[r, 0].max, [r, 255].min].max
		@green = [[g, 0].max, [g, 255].min].max
		@blue = [[b, 0].max, [b, 255].min].max
		
		@value = Color.from_argb(@alfa, @red, @green, @blue)
	end
	
	def initialize(color)
		@alfa = Color.alfa(color)
		@red = Color.red(color)
		@green = Color.green(color)
		@blue = Color.blue(color)
		
		@value = Color.from_argb(@alfa, @red, @green, @blue)
	end
	
	# OPERATOR
	def +(other)
		a = (@alfa + other.alfa) / 2
		r = (@red + other.red) / 2
		g = (@green + other.green) / 2
		b = (@blue + other.blue) / 2
		
		Color.new(Color.from_argb(a, r, g, b))
	end
end
	
class Point < Observer
	def initialize(x = 0, y = 0, color = 0xffff0000)
		super()
		@x, @y = x, y
		@color = color
	end
	
	def clone
		Point.new(@x, @y, @color)
	end
	
	def to_s; "#{@x}, #{@y}" end
	
	def draw(window, size = 1)
		window.draw_line(
			@x - size, @y - size, @color,
			@x + size, @y + size, @color
		)
		window.draw_line(
			@x + size, @y - size, @color,
			@x - size, @y + size, @color
		)
	end

	# GET
	def x; @x end
	def y; @y end
	def color; @color end
	
	# SET
	def x=(value)
		aux = @x
		@x = value
		on_change(self, :x, @x)
	end
	
	def y=(value)
		aux = @y
		@y = value
		on_change(self, :y, aux)
	end
	
	def color=(value)
		aux = @color
		@color = value
		on_change(self, :color, aux)
	end
	
	# METHODS
	def rotate(angle = 0, p = Point.new)
		aux = [@x, @y]
		dx = @x - p.x
		dy = @y - p.y
		r = (dx * dx + dy * dy) ** 0.5
		a = Math.atan2(dy, dx)
		self.x = p.x + r * Math.cos(a + angle)
		self.y = p.y + r * Math.sin(a + angle)
		on_change(self, :xy, aux)
	end
	
	# OPERATOR
	def ^(other)
		Point.new(
			(@x + other.x) / 2,
			(@y + other.y) / 2,
			Color.middle(@color, other.color)
		)
	end
	
	def +(other)
		Point.new(
			@x + other.x,
			@y + other.y,
			@color
		)
	end
	
	def -(other)
		Point.new(
			@x - other.x,
			@y - other.y,
			@color
		)
	end
	
	def *(other)
		if other.instance_of? Point
			@x * other.x + @y * other.y
		end
		Point.new(@x * other, @y * other, @color)
	end
	
	def /(other)
		if other.instance_of? Point
			raise Exception, "No se pueden dividir dos puntos"
		end
		Point.new(@x / other, @y / other, @color)
	end
end

class Line # < Observer
	def initialize(p1, p2)
		#super()
		
		@A, @B = p1, p2
		
		@update = proc { @M = @A ^ @B }
		
		@update.call
		
		@A.add_listener @update
		@B.add_listener @update
		
		@center_update = proc {
			im = @A ^ @B
			m = @M
			@A += m - im 
			@B += m - im
		}
		
		@M.add_listener @center_update
	end
	# METHODS
	def draw(window, point_size = 0)
		window.draw_line(
			@A.x, @A.y, @A.color,
			@B.x, @B.y, @B.color
		)
		if point_size > 0
			@A.draw(window, point_size)
			@B.draw(window, point_size)
			@M.draw(window, point_size)
		end
	end
	
	def rotate(angle = 0)
		m = @M
		@A.rotate(angle, m)
		@B.rotate(angle, m)
		#on_change(self, :AB, 0)
	end
	
	def rotate_at_point(angle = 0, point = Point.new)
		@M.rotate(angle, point)
	end
	
	# GET
	def A; @A end
	def B; @B end
	def center; @M end
	
	# SET
	def A=(value)
		@A = value
		@A.add_listener @update
		#on_change(self, :A, 0)
		#puts "A"
	end
	
	def B=(value)
		@B = value
		@B.add_listener @update
		#on_change(self, :B, 0)
		#puts "B"
	end
	
	def center=(value)
		m = @M
		@A += value - m
		@B += value - m
		@M = @A ^ @B #value
		@M.add_listener @center_update
		#on_change(self, :ABC, 0)
		#puts "Center"
	end
end

class Polygon
	def initialize(points = [], close = true)
		@points = []
		points.each do |point| 
			@points << point
		end
		
		@max_index = @points.length - 1
		
		@lines = []
		
		(0...@max_index).each do |i|
			@lines << Line.new(@points[i], @points[i + 1])
		end
		
		@close = close
		
		if @close and @points.length > 2
			@lines << Line.new(@points.last, @points.first)
		end
	end
	
	def rotate(angle = 0)
		s = Point.new
		@points.each do |point|
			s += point
		end
		
		s /= @points.length
		
		@points.each do |point|
			point.rotate(angle, s)
		end
	end
	
	def rotate_at_point(angle = 0, p)
		@points.each do |point|
			point.rotate(angle, p)
		end
	end
	
	def draw(window, point_size = 0)
		@lines.each do |line|
			line.draw(window, point_size)
		end
	end
	
	def first; @points.first end
	def last; @points.last end
	
	# OPERATOR
	def [](index)
		@points[index]
	end
	
	def <<(other)
		if other.instance_of? Point
			if @close and @points.length > 0
				@lines.pop
			end
			if @points.length > 0
				@lines << Line.new(@points.last, other)
			end
			@points << other
			if @close
				@lines << Line.new(@points.last, @points.first)
			end
		end
	end
end

