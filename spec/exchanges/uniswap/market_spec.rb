require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Uniswap::Market do
  it { expect(described_class::NAME).to eq 'uniswap' }
  it { expect(described_class::API_URL).to eq 'https://api.blocklytics.org/pools/v1' }
end
