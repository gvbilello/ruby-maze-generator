require 'pry'
require 'pry-byebug'

class Cell

  attr_reader :x, :y, :walls
  attr_accessor :visited

  def initialize(args = {})
    @dungeon = args.fetch(:dungeon)
    @x = args.fetch(:x)
    @y = args.fetch(:y)
    # @walls order: top, right, bottom, left
    @walls = [true, true, true, true]
    @visited = false
  end

  def check_neighbors
    neighbors = []
    top = nil
    right = nil
    bottom = nil
    left = nil

    if @y > 0
      top = @dungeon.dungeon[@y - 1][@x]
    end

    if @x > 0
      left = @dungeon.dungeon[@y][@x - 1]
    end

    if @x < @dungeon.width - 1
      right = @dungeon.dungeon[@y][@x + 1]
    end

    if @y < @dungeon.height - 1
      bottom = @dungeon.dungeon[@y + 1][@x]
    end

    # binding.pry
    if top
      if !top.visited
        neighbors << top
      end
    end

    if right
      if !right.visited
        neighbors << right
      end
    end

    if bottom
      if !bottom.visited
        neighbors << bottom
      end
    end

    if left
      if !left.visited
        neighbors << left
      end
    end

    if neighbors.length > 0
      return neighbors.sample
    else
      return nil
    end
  end

end

class Dungeon

  attr_reader :height, :width, :dungeon, :current, :stack

  def initialize(args = {})
    @height = args.fetch(:height, 1)
    @width = args.fetch(:width, 1)
    @dungeon = []
    @current
    @num_of_cells = @height * @width
    @visited_cells = []
    @stack = []
  end

  def create_dungeon
    (1..@height).each do |row|
      new_row = []
      (1..@width).each do |col|
        new_row << Cell.new(dungeon: self, x: col - 1, y: row - 1)
      end
      @dungeon << new_row
    end

  end

  def create_doors
    # start in top left corner
    @current = @dungeon[0][0]
    p "y:#{current.y}, x:#{@current.x}"
    @current.visited = true
    @visited_cells << @current

    until @visited_cells.length == @num_of_cells
      # binding.pry
      next_cell = @current.check_neighbors

      if next_cell
        next_cell.visited = true
        @stack << @current
        remove_walls(@current, next_cell)
        @current = next_cell
        p "y:#{current.y}, x:#{@current.x}"
        @visited_cells << @current
      else
        @current = @stack.pop
      end
    end
  end

  def remove_walls(current_cell, next_cell)
    dx = current_cell.x - next_cell.x
    if dx == 1
      current_cell.walls[3] = false
      next_cell.walls[1] = false
    elsif dx == -1
      current_cell.walls[1] = false
      next_cell.walls[1] = false
    end

    dy = current_cell.y - next_cell.y
    if dy == 1
      current_cell.walls[0] = false
      next_cell.walls[2] = false
    elsif dy == -1
      current_cell.walls[2] = false
      next_cell.walls[0] = false
    end
  end

  def show_dungeon
    @dungeon.each do |row|
      row.each do |cell|
        p cell.visited
        p cell.walls
      end
    end
  end

end

dungeon = Dungeon.new(height: 3, width: 3)
dungeon.create_dungeon
dungeon.create_doors
dungeon.show_dungeon
