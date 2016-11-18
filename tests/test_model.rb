require "test/unit"

require "model"

class TestNAME < Test::Unit::TestCase

  def test_is_valid
    board = Board.new(5, 5)

    assert_true(board.is_valid(position(1, 1)))
    assert_true(board.is_valid(position(0, 0)))
    assert_true(board.is_valid(position(4, 4)))

    assert_false(board.is_valid(position(-1, 4)))
    assert_false(board.is_valid(position(0, 5)))
  end

  def test_roboto_to_s
    roboto = Roboto.new
    assert_equal(roboto.to_s, "Roboto is nowhere and is not looking at any direction")
    roboto.position = position(1, 1)
    assert_equal(roboto.to_s, "Roboto is at [1, 1] and is not looking at any direction")
    roboto.direction = :south
    assert_equal(roboto.to_s, "Roboto is at [1, 1] and is looking south")
  end

  def test_direction_works_properly
    direction = Direction.new(:north)

    assert_equal(direction.turn_left.value, :west)
    assert_equal(direction.turn_right.value, :east)
  end

  def position (x, y)
    Position.new(x, y)
  end
end