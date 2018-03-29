require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::TradeSatoshi::Market do
  it { expect(described_class::NAME).to eq 'trade_satoshi' }
  it { expect(described_class::API_URL).to eq 'https://tradesatoshi.com/api/public' }
end
