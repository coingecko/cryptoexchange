require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinbase::Market do
  it { expect(described_class::NAME).to eq 'coinbase' }
  it { expect(described_class::API_URL).to eq 'https://api.pro.coinbase.com' }
end
