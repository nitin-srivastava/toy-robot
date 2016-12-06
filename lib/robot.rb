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

  def move
    begin
      place_first
      is_valid_move
      case self.orientation
        when 'NORTH' then self.y_coordinate += 1
        when 'EAST' then self.x_coordinate += 1
        when 'SOUTH' then self.y_coordinate -= 1
        when 'WEST' then self.x_coordinate -= 1
      end
    rescue => e
      @error.puts e.message
    end
  end

  # announce robot position
  def report
    puts "#{self.x_coordinate}, #{self.y_coordinate}, #{self.orientation}"
  end

  private

  def is_valid_move
    valid =
      case self.orientation
        when 'NORTH' then self.y_coordinate == table.yaxis.max
        when 'EAST'  then self.x_coordinate == table.xaxis.max
        when 'SOUTH' then self.y_coordinate == table.yaxis.min
        when 'WEST'  then self.x_coordinate == table.xaxis.min
        else false
      end
    raise Exception.new('Move will be unsafe. Turn first.') if valid
  end

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