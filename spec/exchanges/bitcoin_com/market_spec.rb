require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BitcoinCom::Market do
  it { expect(described_class::NAME).to eq 'bitcoin_com' }
  it { expect(described_class::API_URL).to eq 'https://api.exchange.bitcoin.com/api/2/public' }
end
