class CommandsFactory
  def from_string(string)
    command = string.upcase #TODO add more parsing
    case(string)
      when "MOVE" then wrap(MoveCommand.new)
      when "LEFT" then wrap(TurnCommand.new :turn_left)
      when "RIGHT" then wrap(TurnCommand.new :turn_right)
      when "REPORT" then ReportCommand.new
      when "PLACE" then PlaceCommand.new(Position.new(0, 0), Direction.new(:south))
      else UnknownCommand.new(string)
    end
  end

  def wrap (command)
    CheckPlacedCommand.new command
  end
end

class CheckPlacedCommand
  attr_reader :command

  def initialize(command)
    @command = command
  end

  def apply(robot, board)
    if robot.is_placed?
      command.apply robot, board
    else
      "I am still in the limbo, master. You need to place me first."
    end
  end
end

class MoveCommand
  def apply(robot, board)
    new_position = robot.position.move
    if board.is_valid(new_position)
      robot.position = new_position
      "Moving. My new position is #{new_position}, master."
    else
      "Why do you want to kill me, master? I can't go there."
    end
  end
end

class TurnCommand
  TURNS={:turn_left => "left", :turn_right => "right"}
  attr_reader :turn

  def initialize(turn)
    unless TURNS.include?(turn)
      raise ArgumentError, "There is no such turn as #{turn}, only #{TURNS}"
    end
    @turn = turn
  end

  def apply(robot, board)
    old_direction = robot.direction
    robot.direction = old_direction.send(turn)
    "Turning #{TURNS[turn]}, master."
  end
end

class ReportCommand
  def apply(robot, board)
    robot.to_s
  end
end

class PlaceCommand
  attr_reader :position, :direction

  def initialize(position, direction)
    @position = position
    @direction = direction
  end

  def apply(robot, board)
    robot.position = position
    robot.direction = direction
    robot.to_s
  end
end

class UnknownCommand
  attr_reader :wrong_command

  def initialize(wrong_command)
    @wrong_command = wrong_command
  end

  def apply(robot, board)
    "Heh? Not sure what to do, master. What is #{wrong_command}"
  end
end
