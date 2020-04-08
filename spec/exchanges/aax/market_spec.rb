require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Aax::Market do
  it { expect(described_class::NAME).to eq 'aax' }
  it { expect(described_class::API_URL).to eq 'https://api.aax.com/marketdata/v1.1' }
end
