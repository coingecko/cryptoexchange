require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::GoExchange::Market do
  it { expect(described_class::NAME).to eq 'go_exchange' }
  it { expect(described_class::API_URL).to eq 'https://api.go.exchange' }
end
