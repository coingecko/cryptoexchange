require 'spec_helper'

RSpec.describe 'SatoWalletEx integration specs' do
  let(:market) { "sato_wallet_ex" }
  let(:client) { Cryptoexchange::Client.new }
  let(:xzc_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'xzc', target: 'usdt', market: market) }

  it 'fetch pairs' do
    pairs = client.pairs market
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq market
  end

  it 'fetch ticker' do
    ticker = client.ticker xzc_usdt_pair

    expect(ticker.base).to eq xzc_usdt_pair.base
    expect(ticker.target).to eq xzc_usdt_pair.target
    expect(ticker.market).to eq market
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
