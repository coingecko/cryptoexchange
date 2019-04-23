require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::CoinMetro::Market do
  it { expect(described_class::NAME).to eq 'coin_metro' }
  it { expect(described_class::API_URL).to eq 'https://exchange.coinmetro.com' }
end
