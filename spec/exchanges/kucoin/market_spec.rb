require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Kucoin::Market do
  it { expect(described_class::NAME).to eq 'kucoin' }
  it { expect(described_class::API_URL).to eq 'https://openapi-v2.kucoin.com/api/v1' }
end
