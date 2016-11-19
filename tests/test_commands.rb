require "test/unit"
require "test_utils"

require "commands"

class TestCommands < Test::Unit::TestCase
  include TestUtils

  def test_commands
    roboto = Roboto.new
    board = Board.new(100, 100)
    factory = CommandsFactory.new

    #Not moving
    reply = command("MOVE", factory, board, roboto)
    assert_match(/limbo/, reply)
    assert_equal roboto.direction, nil
    assert_equal roboto.position, nil

    #Not turning
    reply = command("LEFT", factory, board, roboto)
    assert_match(/limbo/, reply)
    assert_equal roboto.direction, nil
    assert_equal roboto.position, nil

    #Still reporting
    reply = command("REPORT", factory, board, roboto)
    assert_match(/nowhere/, reply)
    assert_match(/any direction/, reply)
    assert_equal roboto.direction, nil
    assert_equal roboto.position, nil

    #Still reporting
    # reply = command("PLACE 1, 1, SOUTH", factory, board, roboto)
    # assert_match(/1\,1/, reply)
    # assert_match(/south/, reply)
    # assert_equal roboto.direction, nil
    # assert_equal roboto.position, nil

  end
end

