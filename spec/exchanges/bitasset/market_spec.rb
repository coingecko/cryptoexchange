require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitasset::Market do
  it { expect(described_class::NAME).to eq 'bitasset' }
  it { expect(described_class::API_URL).to eq 'https://api.bitasset.com/api/v1' }
end
