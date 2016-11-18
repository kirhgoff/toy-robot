class Position
  attr_reader :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end

  def move(direction)
    case direction
      when :south then Position.new(x, y-1)
      when :north then Position.new(x, y+1)
      when :west then Position.new(x-1, y)
      when :east then Position.new(x+1, y)
    end
  end

  def to_s
    "[#{x}, #{y}]"
  end
end

#----------------------------------

class Direction
  LEFT = {:south => :east, :north => :west, :east => :south, :west => :north}
  RIGHT = {:south => :west, :north => :east, :east => :north, :west => :south}

  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def turn_left
    Direction.new(LEFT[value])
  end

  def turn_right
    Direction.new(RIGHT[value])
  end

  def to_s
    value.to_s
  end

end

#----------------------------------

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

#----------------------------------

class Roboto
  attr_accessor :position, :direction

  def to_s
    position_str = position.nil? ? "nowhere" : "at " + position.to_s
    direction_str = direction.nil? ?
      "not looking at any direction" : "looking " + direction.to_s

    "Roboto is #{position_str} and is #{direction_str}"
  end
end
