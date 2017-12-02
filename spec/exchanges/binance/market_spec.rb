require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Binance::Market do
  it { expect(described_class::NAME).to eq 'binance' }
  it { expect(described_class::API_URL).to eq 'https://www.binance.com/api/v1' }
end
