require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Kucoin::Market do
  it { expect(described_class::NAME).to eq 'kucoin' }
  it { expect(described_class::API_URL).to eq 'https://api.kucoin.com/v1' }
end
