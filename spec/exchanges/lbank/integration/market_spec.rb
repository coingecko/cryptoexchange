require 'spec_helper'

RSpec.describe 'Lbank integration specs' do
  let(:client) { Cryptoexchange::Client.new }

  it 'fetch pairs' do
    pairs = client.pairs('lbank')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'lbank'
  end

  it 'give trade url' do
    eth_btc_pair = Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'BTC', market: 'lbank')
    trade_page_url = client.trade_page_url 'lbank', base: eth_btc_pair.base, target: eth_btc_pair.target
    expect(trade_page_url).to eq "https://www.lbank.info/exchange.html?asset=eth&post=btc"
  end

  it 'fetch ticker' do
    eth_btc_pair = Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'BTC', market: 'lbank')
    ticker = client.ticker(eth_btc_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'lbank'
    expect(ticker.change).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    eth_btc_pair = Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'BTC', market: 'lbank')
    order_book = client.order_book(eth_btc_pair)

    expect(order_book.base).to eq 'ETH'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'lbank'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    eth_btc_pair = Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'BTC', market: 'lbank')
    trades = client.trades(eth_btc_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'ETH'
    expect(trade.target).to eq 'BTC'
    expect(trade.market).to eq 'lbank'
    expect(trade.trade_id).to_not be_nil
    expect(trade.type).to_not be_nil
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(trade.timestamp).year)
    expect(trade.payload).to_not be nil

  end
end
