require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinbit::Market do
  it { expect(described_class::NAME).to eq 'coinbit' }
  it { expect(described_class::API_URL).to eq 'https://coinmarketcapapi.coinbit.co.kr/marketPrice' }
end
