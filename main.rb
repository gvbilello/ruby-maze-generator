@@rows
@@cols
@@cell_width = 40
@@grid = []
@@stack = []
@@current

class MazeWindow << Gosu::Window

  def initialize(width, height)
    super(width, height, false)
    @@cols = width / @@cell_width
    @@rows = height / @@cell_width

    @@rows.each do |row|
      @@cols.each do |col|
        cell = Cell.new(col, row)
        grid << cell
      end
    end

    # maze starts at the top left corner
    @@current = grid[0]
  end

  def draw
  end

end

def update
end

def draw
end

def index(i, j)
  if i < 0 || j < 0 || i > @@cols - 1 || j > @@rows - 1
    return -1
  else
    return i + j * @@cols
  end
end

def remove_walls(current_cell, next_cell)
  x = current_cell.i - next_cell.i
  if x == 1
    current_cell.walls[3] = false
    next_cell.walls[1] = false
  elsif x == -1
    current_cell.walls[1] = false
    next_cell.walls[3] = false
  end

  y = current_cell.j - next_cell.j
  if y == 1
    current_cell.walls[0] = false
    next_cell.walls[2] = false
  elsif y == -1
    current_cell.walls[2] = false
    next_cell.walls[0] = false
  end
end
