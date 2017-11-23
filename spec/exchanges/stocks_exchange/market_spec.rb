require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::StocksExchange::Market do
  it { expect(described_class::NAME).to eq 'stocks_exchange' }
  it { expect(described_class::API_URL).to eq 'https://stocks.exchange/api2' }
end
