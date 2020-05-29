require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Buyucoin::Market do
  it { expect(described_class::NAME).to eq 'buyucoin' }
  it { expect(described_class::API_URL).to eq 'https://api.buyucoin.com/ticker/v1.0' }
end
