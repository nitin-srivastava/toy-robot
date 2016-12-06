require 'rspec'
require_relative '../lib/robot'
require_relative '../lib/table'

describe Robot do

  let(:commands) { ['PLACE 1,2,NORTH', 'RIGHT', 'MOVE', 'MOVE', 'REPORT']}
  let(:robot) { Robot.new(commands) }
  let(:table) { robot.table }

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

    context 'When place the robot with wrong orientation then' do
      it 'should raise an invalid orientation error' do
        expect { robot.place([1, 2, 'NORTHEAST']) }.to raise_error "Invalid direction NORTHEAST. Valid directions are NORTH, EAST, SOUTH and WEST"
      end
    end

    context 'When place the robot with x coordinate exceeded to table range then' do
      it 'should raise an invalid x coordinate error' do
        expect { robot.place([6, 2, 'NORTH']) }.to raise_error "Invalid value 6 for x coordinate. It must be between #{table.xaxis.min} and #{table.xaxis.max} ."
      end
    end

    context 'When place the robot with y coordinate exceeded to table range then' do
      it 'should raise an invalid y coordinate error' do
        expect { robot.place([1, 7, 'NORTH']) }.to raise_error "Invalid value 7 for y coordinate. It must be between #{table.yaxis.min} and #{table.yaxis.max} ."
      end
    end
  end

  describe '#left' do
    context 'When LEFT command has given then' do

      before { robot.place([2, 3, 'NORTH']) }
      it 'should change the robot orientation to the left' do
        expect(robot.left).to eq 'WEST'
      end

      let(:new_robot) { Robot.new(commands) }

      it 'should be ignored the command if robot has not placed' do
        expect { new_robot.left }.to raise_error 'Please place your robot first.'
      end
    end
  end

  describe '#right' do
    context 'When RIGHT command has given then' do

      before { robot.place([2, 3, 'NORTH']) }
      it 'should change the robot orientation to the right' do
        expect(robot.right).to eq 'EAST'
      end

      let(:new_robot) { Robot.new(commands) }
      it 'should be ignored the command if robot has not placed' do
        expect { new_robot.right }.to raise_error 'Please place your robot first.'
      end
    end
  end

  describe '#move' do
    context 'When move command has given then' do
      before do
        robot.place([2, 3, 'EAST'])
        robot.move
      end

      it 'robot should move one step towards orientation' do
        expect(robot.x_coordinate).to eq 3
      end

      let(:new_robot) { Robot.new(commands) }
      it 'should be ignored if robot has not placed' do
        expect { new_robot.move }.to raise_error 'Please place your robot first.'
      end
    end

    context 'When move command is given and move is not safe then' do

      let(:new_robot) { Robot.new(commands) }
      before { new_robot.place([2, 5, 'NORTH']) }
      it 'should raise an error' do
        expect { new_robot.move }.to raise_error 'Move will be unsafe. Turn first.'
      end

    end
  end

  describe '#report' do
    context 'When report command has given then' do
      before do
        robot.place([2, 3, 'EAST'])
        robot.right
        robot.move
        robot.move
      end
      it 'robot current position should be announced' do
        expect { robot.report }.to output("2, 1, SOUTH\n").to_stdout
      end
    end
  end

end