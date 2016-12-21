require_relative 'cell'
require_relative 'dungeon'

require 'rubygems'
require 'gosu'
require 'pry'
require 'pry-byebug'

class MazeWindow < Gosu::Window

  def initialize(height = 800, width = 800, fullscreen = false)
    super
    @cell_width = 10
    @dungeon = Dungeon.new(height: self.height / @cell_width, width: self.width / @cell_width)
    @dungeon.create_dungeon
    @dungeon.create_maze
    @dungeon_cells = @dungeon.dungeon
  end

  def button_down(id)
  	close if id == Gosu::KbEscape
  end

  def update
  end

  def draw
  	@dungeon_cells.each do |row|
      row.each do |cell|
        w = @cell_width
        x = cell.x * w
        y = cell.y * w
        c = 0xff_ffffff
        # draw top wall
        if cell.walls[0]
          draw_line(x, y, c, x + w, y, c, 1)
        end
        # draw right wall
        if cell.walls[1]
          draw_line(x + w, y, c, x + w, y + w, c, 1)
        end
        # draw bottom wall
        if cell.walls[2]
          draw_line(x + w, y + w, c, x, y + w, c, 1)
        end
        # draw left wall
        if cell.walls[3]
          draw_line(x, y + w, c, x, y, c, 1)
        end
      end
    end
  end

end

window = MazeWindow.new
window.show
