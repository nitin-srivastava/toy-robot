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
      validate_coordinates({ 'x' => x.to_i, 'y' => y.to_i })
    rescue => e
      @error.puts e.message
    end
    self.x_coordinate = x.to_i
    self.y_coordinate = y.to_i
    self.orientation = orientation
  end

  def left
    begin
      place_first
      self.orientation = table.directions[table.directions.index(orientation) -1]
    rescue => e
      @error.puts e.message
    end
  end

  def right
    begin
      place_first
      self.orientation = table.directions[table.directions.index(orientation) + 1]
    rescue => e
      @error.puts e.message
    end
  end

  private

  def validate_orientation direction
    raise Exception.new("Invalid direction #{direction}. Valid directions are NORTH, EAST, SOUTH and WEST") unless table.directions.include?(direction)
  end

  def validate_coordinates coordinates
    coordinates.each do |k, v|
      raise Exception.new("Invalid value #{v} for #{k} coordinate. It must be between #{table.send("#{k}axis").min} and #{table.send("#{k}axis").max} .") unless table.send("#{k}axis").cover?(v)
    end
  end

  def place_first
    raise Exception.new('Please place your robot first.') unless is_placed?
  end

  def is_placed?
    table.directions.include?(orientation) && table.xaxis.cover?(x_coordinate) && table.yaxis.cover?(y_coordinate)
  end
end