require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::NebliDex::Market do
  it { expect(described_class::NAME).to eq 'neblidex' }
  it { expect(described_class::API_URL).to eq 'https://www.neblidex.xyz/seed/?v=1&api=get_market_ticker' }
end
