class Robot

  VALID_COMMANDS = ['PLACE', 'LEFT','RIGHT','MOVE','REPORT']

  attr_accessor :commands, :table

  def initialize(commands, stderr=STDERR)
    @commands = commands
    @error = stderr
  end

end