require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitebtc::Market do
  it { expect(described_class::NAME).to eq 'bitebtc' }
  it { expect(described_class::API_URL).to eq 'https://bitebtc.com/api/v1' }
end
