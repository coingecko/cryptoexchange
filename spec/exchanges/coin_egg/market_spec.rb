require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::CoinEgg::Market do
  it { expect(described_class::NAME).to eq 'coin_egg' }
  it { expect(described_class::API_URL).to eq 'https://api.coinegg.com' }
end
