require "test/unit"
require "test_utils"

require "model"

class TestModel < Test::Unit::TestCase
  include TestUtils

  def test_board_is_valid
    board = Board.new(5, 5)

    assert_true board.is_valid(position(1, 1))
    assert_true board.is_valid(position(0, 0))
    assert_true board.is_valid(position(4, 4))
    assert_true board.is_valid(position(0, 4))
    assert_true board.is_valid(position(4, 0))

    assert_false board.is_valid(position(-1, 4))
    assert_false board.is_valid(position(4, -1))
    assert_false board.is_valid(position(0, 5))
    assert_false board.is_valid(position(5, 0))
  end

  def test_equality
    assert_equal position(1, 2), position(1, 2)
    assert_equal direction(:south), direction(:south)
    assert_raise ArgumentError do
      direction :bebebe
    end
  end

  def test_position_move
    position = Position.new(0, 0)

    assert_equal position(0, 1), position.move(direction(:north))
    assert_equal position(0, -1), position.move(direction(:south))
    assert_equal position(-1, 0), position.move(direction(:west))
    assert_equal position(1, 0), position.move(direction(:east))
  end

  def test_roboto_placed_report
    roboto = Roboto.new
    assert_false roboto.is_placed?
    assert_equal "I am nowhere, not facing any direction", roboto.to_s

    roboto.position = position(1, 1)
    assert_false roboto.is_placed?
    assert_equal "I am at [1, 1], not facing any direction", roboto.to_s

    roboto.direction = :south
    assert_true roboto.is_placed?
    assert_equal "I am at [1, 1], facing south", roboto.to_s
  end

  def test_turning_works_properly
    assert_equal direction(:west), direction(:north).turn_left
    assert_equal direction(:east), direction(:north).turn_right

    assert_equal direction(:south), direction(:west).turn_left
    assert_equal direction(:north), direction(:west).turn_right
  end

  def test_direction_is_valid
    assert_false Direction.is_valid?(:dfdsf)
    assert_false Direction.is_valid?(nil)

    assert_true Direction.is_valid?(:south)
    assert_true Direction.is_valid?(:north)
  end
end