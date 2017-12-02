require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::StocksExchange::Services::Pairs do
  it { expect(described_class::PAIRS_URL).to eq 'https://stocks.exchange/api2/markets' }
end
