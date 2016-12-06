require 'table'

class Robot

  VALID_COMMANDS = ['PLACE', 'LEFT','RIGHT','MOVE','REPORT']

  attr_accessor :commands, :table, :x_coordinate, :y_coordinate, :orientation

  def initialize(commands, stderr=STDERR)
    @commands = commands
    @error = stderr
    @table = Table.new()
  end

  # place robot on table
  def place(args)
    x, y, orientation = args
    self.x_coordinate = x.to_i
    self.y_coordinate = y.to_i
    self.orientation = orientation
  end

end