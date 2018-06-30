require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinexmarket::Market do
  it { expect(described_class::NAME).to eq 'coinexmarket' }
  it { expect(described_class::API_URL).to eq 'http://api.coinexmarket.io' }
end
