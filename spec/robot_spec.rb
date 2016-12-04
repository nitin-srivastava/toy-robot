require 'rspec'
require_relative '../lib/robot'
require_relative '../lib/table'

describe Robot do

  let(:commands) { ['PLACE 1,2,NORTH', 'RIGHT', 'MOVE', 'MOVE', 'REPORT']}
  let(:robot) { Robot.new(commands) }

  describe "#new" do
    context 'When robot is initialized with commands' do
      it 'should be a valid instance of robot' do
        expect(robot).to be_instance_of Robot
      end

      it 'should have commands' do
        expect(robot.commands).to match_array(commands)
      end

      it 'should have an instance of table' do
        expect(robot.table).to be_instance_of(Table)
      end
    end

  end
end