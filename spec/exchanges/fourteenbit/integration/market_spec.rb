require 'spec_helper'

RSpec.describe 'FourteenBit integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'foruteenbit' }
  let(:eth_BTC_pair) do
    Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'BTC', market: market)
  end

  it 'fetch pairs' do
    pairs = client.pairs(market)
    expect(pairs).not_to be_empty
    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq market
  end
end
