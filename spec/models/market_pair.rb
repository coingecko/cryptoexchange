require 'spec_helper'

RSpec.describe Cryptoexchange::Models::MarketPair do
  let(:pair) { Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'usd', market: 'market') }
  it { expect(pair.base).to eq 'BTC' }
  it { expect(pair.target).to eq 'USD' }
  it { expect(pair.market).to eq 'market' }
end
