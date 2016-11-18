class ToyRobot
  def run
    print <<EOF
===============================================================
Toy-robot version v1.0
===============================================================
Hello, master,
I am the robot at your command, here are my interface description
- I could be placed in 5x5 board with command PLACE X,Y,F
where 0 <= X,Y < 5 and F=[NORTH|SOUTH|EAST|WEST]
- I will ignore any commands until I am placed on the board
- I will ignore any commands that make me move out of the board
- I can change direction and rotate with LEFT and RIGHT commands
- You can move me one cell with MOVE command
- You can request me to report my whereabouts and location with REPORT command
- You can leave me alone with QUIT or EXIT command

EOF

    prompt = "What do you want me to do, master?>\n"
    while true
      puts prompt
      user_input = gets.chomp.to_s.upcase
      if user_input === 'QUIT' || user_input === 'EXIT'
        puts "Thank you for you efforts, master. Goodbye!"
        break
      end
      puts "You entered #{user_input}"
    end
  end
end