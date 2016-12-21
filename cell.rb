class Cell

  attr_reader :x, :y, :walls
  attr_accessor :visited

  def initialize(args = {})
    @x = args.fetch(:x)
    @y = args.fetch(:y)
    # @walls order: top, right, bottom, left
    @walls = [true, true, true, true]
    @visited = false
  end

end
