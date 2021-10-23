require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BitfinexFutures::Market do
  it { expect(described_class::NAME).to eq 'bitfinex_futures' }
  it { expect(described_class::API_URL).to eq 'https://api-pub.bitfinex.com/v2' }
end
