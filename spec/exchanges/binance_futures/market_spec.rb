require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BinanceFutures::Market do
  it { expect(described_class::NAME).to eq 'binance_futures' }
  it { expect(described_class::API_URL).to eq 'https://fapi.binance.com/fapi/v1' }
  it { expect(described_class::FUTURES_API_URL).to eq 'https://dapi.binance.com/dapi/v1' }
end
