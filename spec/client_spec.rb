require 'spec_helper'

RSpec.describe Cryptoexchange::Client do
  context 'Loads every available exchanges' do
    it 'can find pairs from each exchange' do
      available_exchanges = described_class.available_exchanges
      available_exchanges.each do |exchange|
        expect(described_class.new.pairs(exchange)).to_not be nil
      end
    end

    it 'raise Name error when there is no such exchange in it' do
      expect{described_class.new.pairs('wrong_exchange')}.to raise_error(NameError)
    end
  end
end