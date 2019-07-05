require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinfinit::Market do
  it { expect(described_class::NAME).to eq 'coinfinit' }
  it { expect(described_class::API_URL).to eq 'https://api.coinfinit.com/public' }
end
