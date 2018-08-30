require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Otcbtc::Market do
  it { expect(described_class::NAME).to eq 'otcbtc' }
  it { expect(described_class::API_URL).to eq 'https://otcbtc.com/api/v2' }
end
