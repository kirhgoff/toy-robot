require "test/unit"
require "test_utils"

require "model"

class TestModel < Test::Unit::TestCase
  include TestUtils

  def test_board_is_valid
    board = Board.new(5, 5)

    assert_true(board.is_valid(position(1, 1)))
    assert_true(board.is_valid(position(0, 0)))
    assert_true(board.is_valid(position(4, 4)))

    assert_false(board.is_valid(position(-1, 4)))
    assert_false(board.is_valid(position(0, 5)))
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

    assert_equal position.move(direction(:north)), position(0, -1)
    assert_equal position.move(direction(:south)), position(0, 1)
    assert_equal position.move(direction(:west)), position(-1, 0)
    assert_equal position.move(direction(:east)), position(1, 0)
  end

  def test_roboto_placed_report
    roboto = Roboto.new
    assert_false roboto.is_placed?
    assert_equal roboto.to_s,
                 "Roboto is nowhere and is not looking at any direction"

    roboto.position = position(1, 1)
    assert_false roboto.is_placed?
    assert_equal roboto.to_s,
                 "Roboto is at [1, 1] and is not looking at any direction"

    roboto.direction = :south
    assert_true roboto.is_placed?
    assert_equal roboto.to_s, "Roboto is at [1, 1] and is looking south"
  end

  def test_turning_works_properly
    assert_equal(direction(:north).turn_left, direction(:west))
    assert_equal(direction(:north).turn_right, direction(:east))

    assert_equal(direction(:west).turn_left, direction(:south))
    assert_equal(direction(:west).turn_right, direction(:north))
  end
end