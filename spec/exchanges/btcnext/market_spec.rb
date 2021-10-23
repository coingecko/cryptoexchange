require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Btcnext::Market do
  it { expect(described_class::NAME).to eq 'btcnext' }
  it { expect(described_class::API_URL).to eq 'https://cmc-gate.btcnext.io/marketdata/cmc/v1' }
end
