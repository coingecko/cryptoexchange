require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Openledger::Market do
  it { expect(described_class::NAME).to eq 'openledger' }
  it { expect(described_class::API_URL).to eq 'https://stat-api.openledger.info/api/v1' }
end
