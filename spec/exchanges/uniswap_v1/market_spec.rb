require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::UniswapV1::Market do
  it { expect(described_class::NAME).to eq 'uniswap_v1' }
  it { expect(described_class::API_URL).to eq 'https://api.blocklytics.org/uniswap/v1' }
end
