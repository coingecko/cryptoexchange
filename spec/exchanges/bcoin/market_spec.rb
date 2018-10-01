require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bcoin::Market do
  it { expect(described_class::NAME).to eq 'bcoin' }
  it { expect(described_class::API_URL).to eq 'https://www.bcoin.sg/v1/api/market/hour24Market' }
end
