require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinut::Market do
  it { expect(described_class::NAME).to eq 'coinut' }
  it { expect(described_class::API_URL).to eq 'https://api.coinut.com' }
end
