require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::DydxPerpetual::Market do
  it { expect(described_class::NAME).to eq 'dydx_perpetual' }
  it { expect(described_class::API_URL).to eq 'https://api.dydx.exchange/v1' }
end
