require 'spec_helper'

RSpec.describe 'BtcTradeUa integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:ltc_uah_pair) { Cryptoexchange::Models::MarketPair.new(base: 'LTC', target: 'UAH', market: 'btc_trade_ua') }

  it 'fetch pairs' do
    pairs = client.pairs('btc_trade_ua')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'btc_trade_ua'
  end

  it 'fetch ticker' do
    ticker = client.ticker(ltc_uah_pair)

    expect(ticker.base).to eq 'LTC'
    expect(ticker.target).to eq 'UAH'
    expect(ticker.market).to eq 'btc_trade_ua'
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


  pending 'fetch trade' do
    trades = client.trades(ltc_uah_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.trade_id).to_not be_nil
    expect(trade.base).to eq 'LTC'
    expect(trade.target).to eq 'UAH'
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'btc_trade_ua'
  end
end
