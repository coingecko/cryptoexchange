require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cryptobulls::Market do
  it { expect(described_class::NAME).to eq 'cryptobulls' }
  it { expect(described_class::API_URL).to eq 'https://www.cryptobulls.exchange' }
end
