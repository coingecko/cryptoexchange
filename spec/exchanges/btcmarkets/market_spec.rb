require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Btcmarkets::Market do
  it { expect(described_class::NAME).to eq 'btcmarkets' }
  it { expect(described_class::API_URL).to eq 'https://api.btcmarkets.net' }
end
