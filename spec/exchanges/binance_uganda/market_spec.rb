require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BinanceUganda::Market do
  it { expect(described_class::NAME).to eq 'binance_uganda' }
  it { expect(described_class::API_URL).to eq 'https://api.binance.co.ug/api/v1' }
end
