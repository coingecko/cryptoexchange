require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Kryptono::Market do
  it { expect(described_class::NAME).to eq 'kryptono' }
  it { expect(described_class::API_URL).to eq 'https://engines.kryptono.exchange/api/v1' }
  it { expect(described_class::MARKET_API_URL).to eq 'https://api.kryptono.exchange/v1/getmarketsummaries' }
end
