require 'rspec'
require_relative '../lib/robot'

describe Robot do

  let(:robot) { Robot.new() }

  describe "#new" do
    it { is_expected.to be_a(Robot) }
  end
end