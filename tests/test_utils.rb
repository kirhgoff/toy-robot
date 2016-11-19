module TestUtils
  def position (x, y)
    Position.new(x, y)
  end

  def direction (v)
    Direction.new(v)
  end

  def command(string, factory, board, roboto)
    factory.from_string(string).apply(roboto, board)
  end
end