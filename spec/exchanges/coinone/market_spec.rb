require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinone::Market do
  it { expect(described_class::NAME).to eq 'coinone' }
  it { expect(described_class::API_URL).to eq 'https://api.coinone.co.kr' }
end
