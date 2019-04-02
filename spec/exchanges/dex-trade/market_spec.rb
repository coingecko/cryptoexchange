require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Dextrade::Market do
  it { expect(described_class::NAME).to eq 'Dextrade' }
  it { expect(described_class::API_URL).to eq 'https://api.dex-trade.com/v1/coingecko' }
end
