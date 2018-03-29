require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Hksy::Market do
  it { expect(described_class::NAME).to eq 'hksy' }
  it { expect(described_class::MARKET_API_URL).to eq 'https://openapi.hksy.com/app/coinMarket/v1' }
  it { expect(described_class::TRADE_API_URL).to eq 'https://openapi.hksy.com/app/tradeCenter/v1' }
end
