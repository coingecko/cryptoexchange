require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Raidofinance::Market do
  it { expect(described_class::NAME).to eq 'raidofinance' }
  it { expect(described_class::API_URL).to eq 'https://datacenter.raidofinance.eu/v1' }
end
