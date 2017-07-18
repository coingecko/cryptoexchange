require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Lakebtc::Market do
  it { expect(described_class::NAME).to eq 'lakebtc' }
  it { expect(described_class::API_URL).to eq 'https://api.lakebtc.com/api_v2' }
end
