require './lib/model'
require './lib/commands'

class AutomaticRobot
  def run
    puts "==============================================================="
    puts "Roboto version v1.0"

    if ARGV.length == 0
      puts "Please provide list of file names with commands to execute."
      return
    end

    board = Board.new(5, 5)
    factory = CommandsFactory.new

    ARGV.each do |arg|
      begin
        puts "---------------------------------------------------------------"
        puts "Processing file: #{arg}"

        roboto = Roboto.new
        File.open(arg).each do |line|
          line = line.strip.upcase
          puts line
          command = factory.from_string(line)
          if line == "REPORT"
            report roboto
          else
            command.apply roboto, board
          end
        end
      rescue
        puts "Cannot open file: #{arg}"
      end
    end
  end

  def report(roboto)
    x = roboto.position.x
    y = roboto.position.y
    direction = roboto.direction.to_s.upcase

    puts "#{x},#{y},#{direction}"
  end
end

AutomaticRobot.new.run