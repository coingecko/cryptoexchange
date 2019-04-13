require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::TronTrade::Market do
  it { expect(described_class::NAME).to eq 'tron_trade' }
  it { expect(described_class::API_URL).to eq 'https://trontrade.io/graphql' }
end
