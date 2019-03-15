require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitmesh::Market do
  it { expect(described_class::NAME).to eq 'bitmesh' }
  it { expect(described_class::API_URL).to eq 'https://api.bitmesh.com/?api=market.ticker' }
end
