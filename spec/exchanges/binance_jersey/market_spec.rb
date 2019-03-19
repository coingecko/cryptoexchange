require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BinanceJersey::Market do
  it { expect(described_class::NAME).to eq 'binance_jersey' }
  it { expect(described_class::API_URL).to eq 'https://api.binance.je/api/v1' }
end
