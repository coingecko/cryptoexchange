require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinasset::Market do
  it { expect(described_class::NAME).to eq 'coinasset' }
  it { expect(described_class::API_URL).to eq 'https://api.coinasset.co.th/api/v1' }
end
