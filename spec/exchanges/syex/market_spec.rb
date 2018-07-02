require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Syex::Market do
  it { expect(described_class::NAME).to eq 'syex' }
  it { expect(described_class::API_URL).to eq 'https://api-new.syex.io/pc/coinMarket/v1' }
  it { expect(described_class::TARGET_SYM).to eq 'USDT' }
end
