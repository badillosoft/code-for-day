# Alan Badillo Salas
# @badillo.soft | badillo.soft@hotmail.com
# Octubre 2015

require 'gosu'
require_relative 'core'

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "badillosoft - Clock"
    @w_2 = self.width / 2
    @h_2 = self.height / 2
    @center = Point.new(@w_2, @h_2)
    
    @poly = Polygon.new([
      Point.new(-40, -40, Color.Red) + @center,
      Point.new(40, -40, Color.Green) + @center,
      Point.new(40, 40, Color.Blue) + @center,
      Point.new(-40, 40, Color.from_rgba(255, 255, 255)) + @center
    ])
    
    @poly << Point.new(-100, 0, Color.from_rgba(0, 255, 255)) + @center
    
    @circle = Polygon.new
    
    delta = 1.0 / 20.0
    
    (1..20).each do |n|
      pi2 = 2.0 * Math::PI
      t = delta * n * pi2
      x = 100 * Math.cos(t)
      y = 100 * Math.sin(t)
      
      r = Integer(255.0 * t / pi2)
      g = 0 #Integer(127.0 * t / pi2)
      b = 255 - r
      
      @circle << Point.new(x, y, Color.from_rgba(r, g, b)) + @center
    end
  end

  def update
    #@poly.first.y -= 0.1
    #@poly[3].y += 0.1
    #@poly.rotate(0.01)
    @poly.rotate_at_point(0.1, @center)
  end

  def draw
    @poly.draw self
    @circle.draw self
  end
  
  def button_down(id)
  end
end

window = GameWindow.new
window.show