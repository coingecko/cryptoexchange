require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BinanceUs::Market do
  it { expect(described_class::NAME).to eq 'binance_us' }
  it { expect(described_class::API_URL).to eq 'https://api.binance.us/api/v1' }
end
