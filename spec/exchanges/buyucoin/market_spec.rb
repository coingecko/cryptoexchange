require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Buyucoin::Market do
  it { expect(described_class::NAME).to eq 'buyucoin' }
  it { expect(described_class::API_URL).to eq 'https://www.buyucoin.com/api/v1.2' }
end
