class Position
  attr_reader :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end

  def move(direction)
    case direction.value
      when :north then Position.new(x, y+1)
      when :south then Position.new(x, y-1)
      when :west then Position.new(x-1, y)
      when :east then Position.new(x+1, y)
      else
        raise "Unknown direction " + direction
    end
  end

  def to_s
    "[#{x}, #{y}]"
  end

  def ==(other)
    other != nil && x == other.x && y == other.y
  end
end

#----------------------------------

class Direction
  COUNTERCLOCKWISE = {:south => :east, :north => :west, :east => :north, :west => :south}
  CLOCKWISE = COUNTERCLOCKWISE.invert

  attr_reader :value

  def self.is_valid?(symbol)
    CLOCKWISE.key?(symbol)
  end

  def initialize(value)
    unless CLOCKWISE.key?(value)
      raise ArgumentError, "Cannot accept value #{value}, should be one of #{CLOCKWISE.keys}"
    end
    @value = value
  end

  def turn_left
    Direction.new(COUNTERCLOCKWISE[value])
  end

  def turn_right
    Direction.new(CLOCKWISE[value])
  end

  def to_s
    value.to_s
  end

  def ==(other)
    other != nil && value == other.value
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

  def is_placed?
    position != nil && direction != nil
  end

  def to_s
    position_str = position.nil? ? "nowhere" : "at " + position.to_s
    direction_str = direction.nil? ?
      "not facing any direction" : "facing " + direction.to_s

    "I am #{position_str}, #{direction_str}"
  end
end

