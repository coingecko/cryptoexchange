require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coingi::Market do
  it { expect(described_class::NAME).to eq 'coingi' }
  it { expect(described_class::API_URL).to eq 'https://api.coingi.com' }
end
