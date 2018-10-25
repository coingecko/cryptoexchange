require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Tradeio::Market do
  it { expect(described_class::NAME).to eq 'tradeio' }
  it { expect(described_class::API_URL).to eq 'https://api.exchange.trade.io' }
end
