require_relative 'robot'

class Client

  def initialize(args, stdin=STDIN)
    args = stdin.readlines if args.empty?
    @robot = Robot.new(args)
    @robot.start
  end
end