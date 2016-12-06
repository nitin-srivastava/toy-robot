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
    begin
      validate_orientation(orientation)
      validate_x_coordinate(x.to_i)
    rescue => e
      @error.puts e.message
    end
    self.x_coordinate = x.to_i
    self.y_coordinate = y.to_i
    self.orientation = orientation
  end

  private

  def validate_orientation direction
    raise Exception.new("Invalid direction #{direction}. Valid directions are NORTH, EAST, SOUTH and WEST") unless table.directions.include?(direction)
  end

  def validate_x_coordinate x
    raise Exception.new("Invalid value 6 for x coordinate. It must be between 0 and 5 .") unless table.xaxis.cover?(x)
  end

end