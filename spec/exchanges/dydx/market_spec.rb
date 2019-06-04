require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Dydx::Market do
  it { expect(described_class::NAME).to eq 'dydx' }
  it { expect(described_class::API_URL).to eq 'https://api.dydx.exchange/v1/stats/markets' }
end
