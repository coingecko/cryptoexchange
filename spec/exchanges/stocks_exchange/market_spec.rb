require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::StocksExchange::Market do
  it { expect(described_class::NAME).to eq 'stocks_exchange' }
  it { expect(described_class::API_URL).to eq 'https://api3.stex.com/public' }
end
