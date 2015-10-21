# Alan Badillo Salas
# @badillo.soft | badillo.soft@hotmail.com
# Octubre 2015

require 'gosu'
require_relative 'core'

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "badillosoft - Painter"
    @w_2 = self.width / 2
    @h_2 = self.height / 2
    @center = Point.new(@w_2, @h_2)
    
	@polys = [Polygon.new([], false)]
	
	@on_draw = false
	
	@cursor = Point.new
  end

  def update
  	@cursor.x = self.mouse_x
	@cursor.y = self.mouse_y
  
  	if @on_draw
	  @polys.last << Point.new(self.mouse_x, self.mouse_y, Color.from_rgba(255, 255, 0))
	end
  end

  def draw
  	@polys.each do |poly| poly.draw self end
	@cursor.draw self
  end
  
  def button_down(id)
  	@on_draw = true
  end
  
  def button_up(id)
  	@on_draw = false
	@polys << Polygon.new([], false)
  end
end

window = GameWindow.new
window.show