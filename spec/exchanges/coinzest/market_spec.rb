require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinzest::Market do
  it { expect(described_class::NAME).to eq 'coinzest' }
  it { expect(described_class::API_URL).to eq 'https://api.coinzest.co.kr/api/public' }
end
