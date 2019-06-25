require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Uniswap::Market do
  it { expect(described_class::NAME).to eq 'uniswap' }
  it { expect(described_class::API_URL).to eq 'https://api-test-238309.appspot.com/v0/exchanges' }
end
