require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinxpro::Market do
  it { expect(described_class::NAME).to eq 'coinxpro' }
  it { expect(described_class::API_URL).to eq 'https://api.coinx.pro/rest/v1/tickers' }
end
