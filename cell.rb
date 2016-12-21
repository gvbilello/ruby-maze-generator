class Cell

  def initialize(i, j)
    @i = i
    @j = j
    # walls array order: top, right, bottom, left
    @walls = [true, true, true, true]
    @visited = false
  end

  def highlight
    x = self.i * @@width
    y = self.j * @@width
    # highlight cell
  end

  def check_neighbors
    neighbors = []
    top = @@grid[index(i, j - 1)]
    right = @@grid[index(i + 1, j)]
    bottom = @@grid[index(i, j + 1)]
    left = @@grid[index(i - 1, j)]

    if top && !top.visited
      neighbors << top
    end

    if right && !right.visited
      neighbors << right
    end

    if bottom && !bottom.visited
      neighbors << bottom
    end

    if left && !left.visited
      neighbors << left
    end

    if neighbors.length > 0
      return neighbors.sample
    else
      return nil
    end
  end

  def show
    x = self.i * @@width
    y = self.j * @@width
    # create walls if they exist
  end

end
