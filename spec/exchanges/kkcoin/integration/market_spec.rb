require 'spec_helper'

RSpec.describe 'Kkcoin integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eprx_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ePRX', target: 'ETH', market: 'kkcoin') }

  it 'fetch pairs' do
    pairs = client.pairs('kkcoin')
    expect(pairs).not_to be_empty

    pair = pairs.sample
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'kkcoin'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'kkcoin', base: eprx_eth_pair.base, target: eprx_eth_pair.target
    expect(trade_page_url).to eq "https://www.kkcoin.com/trade?symbol=EPRX_ETH"
  end

  it 'fetch ticker' do
    ticker = client.ticker(eprx_eth_pair)

    expect(ticker.base).to eq 'EPRX'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'kkcoin'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(eprx_eth_pair)

    expect(order_book.base).to eq 'EPRX'
    expect(order_book.target).to eq 'ETH'
    expect(order_book.market).to eq 'kkcoin'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 0
    expect(order_book.bids.count).to be > 0
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(eprx_eth_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.trade_id).to be_nil
    expect(trade.base).to eq 'EPRX'
    expect(trade.target).to eq 'ETH'
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'kkcoin'
  end

end
