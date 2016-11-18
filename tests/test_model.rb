require "test/unit"

require "model"

class TestNAME < Test::Unit::TestCase

  def test_is_valid
    board = Board.new(5, 5)
    def position (x, y)
      Position.new(x, y)
    end

    assert_true(board.is_valid(position(1, 1)))
    assert_true(board.is_valid(position(0, 0)))
    assert_true(board.is_valid(position(4, 4)))

    assert_false(board.is_valid(position(-1, 4)))
    assert_false(board.is_valid(position(0, 5)))
  end

end