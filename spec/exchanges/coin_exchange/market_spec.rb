require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::CoinExchange::Market do
  it { expect(described_class::NAME).to eq 'coin_exchange' }
  it { expect(described_class::API_URL).to eq 'https://www.coinexchange.io/api/v1' }
end
