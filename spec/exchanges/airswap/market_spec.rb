require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Airswap::Market do
  it { expect(described_class::NAME).to eq 'airswap' }
  it { expect(described_class::API_URL).to eq 'https://maker-stats.production.airswap.io' }
end
