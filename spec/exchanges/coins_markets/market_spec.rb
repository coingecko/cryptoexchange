require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::CoinsMarkets::Market do
  it { expect(described_class::API_URL).to eq 'https://coinsmarkets.com' }
end
