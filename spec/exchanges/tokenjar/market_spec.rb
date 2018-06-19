require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Tokenjar::Market do
  it { expect(described_class::NAME).to eq 'tokenjar' }
  it { expect(described_class::API_URL).to eq 'https://tokenjar.io/api/cmc' }
end
