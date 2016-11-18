class Position
  attr_reader :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end
end

class Board
  attr_reader :width, :height
  def initialize(width, height)
    @width = width
    @height = height
  end

  def is_valid(position)
    position.x >= 0 &&
      position.x < width &&
      position.y >= 0 &&
      position.y < height
  end
end