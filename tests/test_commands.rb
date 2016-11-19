require "test/unit"
require "test_utils"

require "commands"

class TestCommands < Test::Unit::TestCase
  include TestUtils
  attr_reader :factory

  def initialize(test_method_name)
    super(test_method_name)
    @factory = CommandsFactory.new
  end

  def test_parse_params
    assert_parse("1, 1, SOUTH", position(1, 1), direction(:south))
    assert_parse("-1, 5, NORTH", position(-1, 5), direction(:north))
    assert_parse("724,32,EAST", position(724, 32), direction(:east))
    assert_parse("4,5,WesT", position(4, 5), direction(:west))

    assert_parse("724,32,dsfd", position(724, 32), nil)
    assert_parse(",,east", nil, direction(:east))
    assert_parse("a,b,east", nil, direction(:east))
    assert_parse("724,,dsfd", nil, nil)
    assert_parse("s,,dsfd", nil, nil)
    assert_parse("sfsdfsdsfd", nil, nil)
  end

  def test_commands
    roboto = Roboto.new
    board = Board.new(100, 100)

    #Not moving
    reply = command("MOVE", board, roboto)
    assert_match(/limbo/, reply)
    assert_state(roboto, nil, nil)

    #Not turning
    reply = command("LEFT", board, roboto)
    assert_match(/limbo/, reply)
    assert_state(roboto, nil, nil)

    #Still reporting
    reply = command("REPORT", board, roboto)
    assert_match(/nowhere/, reply)
    assert_match(/any direction/, reply)
    assert_state(roboto, nil, nil)

    #Place command is working
    reply = command("PLACE 1, 1, SOUTH", board, roboto)
    assert_match(/1\, 1/, reply)
    assert_match(/south/, reply)
    assert_state(roboto, position(1, 1), direction(:south))

    #Place command is working again
    reply = command("PLACE 2, 2, NORTH", board, roboto)
    assert_match(/2\, 2/, reply)
    assert_match(/north/, reply)
    assert_state(roboto, position(2, 2), direction(:north))

    #Turn command
    reply = command("RIGHT", board, roboto)
    assert_match(/right/, reply)
    assert_state(roboto, position(2, 2), direction(:east))

    #Move command
    reply = command("MOVE", board, roboto)
    assert_match(/Moving/, reply)
    assert_state(roboto, position(3, 2), direction(:east))

    #Move after the edge
    command("LEFT", board, roboto) #north
    command("MOVE", board, roboto) #3, 1
    command("MOVE", board, roboto) #3, 0
    reply = command("MOVE", board, roboto)
    assert_match(/can't go there/, reply)
    assert_state(roboto, position(3, 0), direction(:north))

    reply = command("PLACE 666, 666, NorTH", board, roboto)
    assert_match(/no such place/, reply)
    assert_state(roboto, position(3, 0), direction(:north))

    reply = command("PLACE 5, 5, UP", board, roboto)
    assert_match(/need direction/, reply)
    assert_state(roboto, position(3, 0), direction(:north))
  end

  def assert_state(roboto, position, direction)
    assert_equal roboto.direction, direction
    assert_equal roboto.position, position
  end

  def command(string, board, roboto)
    factory.from_string(string).apply(roboto, board)
  end

  def assert_parse(string, position, direction)
    assert_equal [position, direction], factory.parse_params(string)
  end
end

