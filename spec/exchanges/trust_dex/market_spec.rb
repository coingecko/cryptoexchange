require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::TrustDex::Market do
  it { expect(described_class::NAME).to eq 'trust_dex' }
  it { expect(described_class::API_URL).to eq 'https://trustdex.io/market/api' }
end
