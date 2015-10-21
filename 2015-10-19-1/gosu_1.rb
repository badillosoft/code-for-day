# Alan Badillo Salas
# @badillo.soft | badillo.soft@hotmail.com
# Octubre 2015

require 'gosu'
require_relative 'core'

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "badillosoft - Lines"
    @w_2 = self.width / 2
    @h_2 = self.height / 2
    @center = Point.new(@w_2, @h_2)
    
    @l = Line.new(
      Point.new(@w_2 - 40, @h_2 - 40, Color.Red), 
      Point.new(@w_2 + 40, @h_2 + 40, Color.Green)
    )
    
    @l2 = Line.new(
      Point.new(-40, 0, Color.Red), 
      Point.new(40, 0, Color.Blue)
    ) 
    
    @l.center = Point.new(200, 200)
    @l2.center = @l.B
    
    @p = Point.new(@w_2, @h_2, Color.Blue)
    
    @cursor = Point.new(
      self.mouse_x, self.mouse_y, Color.Red
    )
  end

  def update
    @cursor.x = self.mouse_x
    @cursor.y = self.mouse_y
    
    @p += Point.new(0.3, 0.3)
    
    @l.rotate(-0.02)
    @l.center.rotate(0.05, @p)
    @l2.rotate(0.1)
    @l2.center = @l.B
  end

  def draw
    @l.draw self
    @l2.draw self
    @p.draw(self, 10)
    @cursor.draw(self, 10)
  end
  
  def button_down(id)
    @l.center.x = self.mouse_x
    @l.center.y = self.mouse_y
  end
end

window = GameWindow.new
window.show