require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Exmarkets::Market do
  it { expect(described_class::NAME).to eq 'exmarkets' }
  it { expect(described_class::API_URL).to eq 'https://exmarkets.com/api/trade/v1' }
end
