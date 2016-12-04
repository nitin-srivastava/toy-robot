require 'rspec'
require_relative '../lib/table'

describe Table do

  describe "#new" do
    let(:table) { Table.new() }

    context 'When 5X5 table is created' do
      it {is_expected.to be_a(Table)}
    end
  end

end