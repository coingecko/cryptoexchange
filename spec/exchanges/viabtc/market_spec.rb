require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Viabtc::Market do
  it { expect(described_class::NAME).to eq 'viabtc' }
  it { expect(described_class::API_URL).to eq 'https://www.viabtc.com/api/v1' }
end
