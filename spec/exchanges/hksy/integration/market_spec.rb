require 'spec_helper'

RSpec.describe 'Hksy integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_hkd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'HKD', market: 'hksy') }

  it 'fetch pairs' do
    pairs = client.pairs('hksy')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'hksy'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_hkd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'HKD'
    expect(ticker.market).to eq 'hksy'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(btc_hkd_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'HKD'
    expect(trade.price).to_not be nil
    expect(trade.amount).to_not be nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'hksy'
  end
end
