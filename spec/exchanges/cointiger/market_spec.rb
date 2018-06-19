require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cointiger::Market do
  it { expect(described_class::NAME).to eq 'cointiger' }
  it { expect(described_class::API_URL).to eq 'https://api.cointiger.pro/exchange/trading/api/market' }
  it { expect(described_class::MARKET_URL).to eq 'https://www.cointiger.pro/exchange/api/public/market/detail' }
end
