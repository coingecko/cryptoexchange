require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::OkexSwap::Market do
  it { expect(described_class::NAME).to eq 'okex_swap' }
  it { expect(described_class::API_URL).to eq 'https://www.okex.com/api/swap/v3' }
end
