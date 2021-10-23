require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Atomars::Market do
  it { expect(described_class::NAME).to eq 'Atomars' }
  it { expect(described_class::API_URL).to eq 'https://api.atomars.com/v1/coingecko' }
end
