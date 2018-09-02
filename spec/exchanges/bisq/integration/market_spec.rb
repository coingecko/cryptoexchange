require 'spec_helper'

RSpec.describe 'Bisq integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:bch_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BCH', target: 'BTC', market: 'bisq') }

  it 'fetch pairs' do
    pairs = client.pairs('bisq')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bisq'
  end

  it 'fetch ticker' do
    ticker = client.ticker(bch_btc_pair)

    expect(ticker.base).to eq 'BCH'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'bisq'

    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric

    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(bch_btc_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'BCH'
    expect(trade.target).to eq 'BTC'
    expect(trade.market).to eq 'bisq'

    expect(trade.trade_id).to_not be_nil
    expect(['BUY', 'SELL']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
