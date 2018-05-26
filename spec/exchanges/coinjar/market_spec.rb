require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinjar::Market do
  it { expect(described_class::NAME).to eq 'coinjar' }
  it { expect(described_class::API_URL).to eq 'https://data.exchange.coinjar.com/products' }
end
