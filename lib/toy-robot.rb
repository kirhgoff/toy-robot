require File.dirname(__FILE__) + '/model' #How to make it work properly?!
require File.dirname(__FILE__) + '/commands'

class ToyRobot
  def run
    print <<EOF
===============================================================
Toy-robot version v1.0
===============================================================
Hello master,
I am the robot at your command, here is my interface description:
* I could be placed in 5x5 board with command PLACE X,Y,F
where 0 <= X,Y < 5 and F=[NORTH|SOUTH|EAST|WEST]
* I will ignore any commands until I am placed on the board
* I will ignore any commands that make me move out of the board
* I can change direction and rotate with LEFT and RIGHT commands
* You can move me one cell forward with MOVE command
* You can request to report my whereabouts and location with REPORT command
* You can leave me alone with QUIT or EXIT command

EOF

    board = Board.new(5, 5)
    roboto = Roboto.new
    factory = CommandsFactory.new
    puts "Roboto: What do you want me to do, master?"
    prompt = "Master:"
    while true
      print prompt
      user_input = gets.chomp.to_s.upcase
      if user_input === 'QUIT' || user_input === 'EXIT'
        puts "Roboto: thank you for you efforts, master. Goodbye!"
        break
      end

      command = factory.from_string user_input
      reply = command.apply roboto, board
      puts "Roboto: " + reply
    end
  end
end