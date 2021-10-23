require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Etorox::Market do
  it { expect(described_class::NAME).to eq 'etorox' }
  it { expect(described_class::API_URL).to eq 'https://services.etorox.com/api/v1/marketdata/instruments' }
end