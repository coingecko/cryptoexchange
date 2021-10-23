require 'spec_helper'

RSpec.describe 'Elitex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USDT', market: 'elitex') }

  it 'fetch pairs' do
    pairs = client.pairs('elitex')
    expect(pairs).not_to be_empty

    pair = btc_usdt_pair
    expect(pair.base).to eq 'BTC'
    expect(pair.target).to eq 'USDT'
    expect(pair.market).to eq 'elitex'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'elitex', base: btc_usdt_pair.base, target: btc_usdt_pair.target
    expect(trade_page_url).to eq "https://www.elitex.io/#/en-US/trade/home?symbol=BTC_USDT"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usdt_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq 'elitex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(btc_usdt_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.trade_id).to_not be_nil
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'USDT'
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be nil
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'elitex'
  end
end
