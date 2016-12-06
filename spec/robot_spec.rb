require 'rspec'
require_relative '../lib/robot'
require_relative '../lib/table'

describe Robot do

  let(:commands) { ['PLACE 1,2,NORTH', 'RIGHT', 'MOVE', 'MOVE', 'REPORT']}
  let(:robot) { Robot.new(commands) }

  describe '#new' do
    context 'When robot is initialized' do
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

  describe '#place' do

    context 'When robot is placed on the table' do
      before { robot.place([1, 2, 'NORTH'])}

      it 'should assign 1 to robot x coordinate' do
        expect(robot.x_coordinate).to eq 1
      end

      it 'should assign 2 to robot y coordinate' do
        expect(robot.y_coordinate).to eq 2
      end

      it 'should set robot orientation to NORTH' do
        expect(robot.orientation).to eq 'NORTH'
      end
    end

  end

end