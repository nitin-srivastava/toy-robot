class Table

  attr_accessor :xaxis, :yaxis, :directions

  def initialize(x=5, y=5)
    @xaxis = (0..x.to_i)
    @yaxis = (0..y.to_i)
    @directions = %w(NORTH EAST SOUTH WEST)
  end

end