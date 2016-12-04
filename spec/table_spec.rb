require 'rspec'
require_relative '../lib/table'

describe Table do

  describe "#new" do
    let(:table) { Table.new() }

    context 'When 5X5 table is created' do
      it {is_expected.to be_a(Table)}

      it 'should have 0 minimum x coordinate' do
        expect(table.xaxis.min).to be 0
      end

      it 'should have 5 maximum x coordinate' do
        expect(table.xaxis.max).to be 5
      end

      it 'should have 0 minimum y coordinate' do
        expect(table.yaxis.min).to be 0
      end

      it 'should have 5 maximum y coordinate' do
        expect(table.yaxis.max).to be 5
      end

      it 'should have NORTH, EAST, SOUTH and WEST directions' do
        expect(table.directions).to eq ['NORTH', 'EAST', 'SOUTH', 'WEST']
      end
    end
  end

end