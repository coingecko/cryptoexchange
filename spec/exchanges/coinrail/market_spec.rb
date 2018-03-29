require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinrail::Market do
  it { expect(described_class::NAME).to eq 'coinrail' }
  it { expect(described_class::API_URL).to eq 'https://api.coinrail.co.kr' }
end
