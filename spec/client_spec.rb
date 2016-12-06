require 'rspec'
require_relative '../lib/client'

describe Client do

  let(:argv) { ['PLACE 1,2,EAST', 'MOVE', 'LEFT'] }

  describe "#new" do
    let(:client) { Client.new(argv) }

    it 'should create a valid Client' do
      expect(client).to be_instance_of Client
    end
  end

end