require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinzo::Market do
  it { expect(described_class::NAME).to eq 'coinzo' }
  it { expect(described_class::API_URL).to eq 'https://api.coinzo.com' }
end
