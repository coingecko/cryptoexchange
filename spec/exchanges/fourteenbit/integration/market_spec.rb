require 'spec_helper'

RSpec.describe 'Fourteenbit integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_wco_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'WCO', market: 'fourteenbit') }

  it 'fetch pairs' do
    pairs = client.pairs('fourteenbit')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'fourteenbit'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_wco_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'WCO'
    expect(ticker.market).to eq 'fourteenbit'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(btc_wco_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'WCO'
    expect(trade.price).to_not be nil
    expect(trade.amount).to_not be nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'fourteenbit'
  end
end
