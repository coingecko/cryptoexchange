require 'spec_helper'

RSpec.describe 'Cobinhood integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:usd_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'cobinhood') }

  it 'fetch pairs' do
    pairs = client.pairs('cobinhood')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'cobinhood'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'cobinhood', base: usd_btc_pair.base, target: usd_btc_pair.target
    expect(trade_page_url).to eq "https://cobinhood.com/trade/BTC-USD"
  end

  it 'fetch pairs and assign the correct base/target' do
    pairs = client.pairs('cobinhood')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to eq 'BTC'
    expect(pair.target).to eq 'USD'
    expect(pair.market).to eq 'cobinhood'
  end

  it 'fetch ticker' do
    ticker = client.ticker(usd_btc_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'cobinhood'
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    pair = Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'cobinhood')
    order_book = client.order_book(pair)

    expect(order_book.payload['error']).to_not eq 'Invalid Symbols Pair'
    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'USD'
    expect(order_book.market).to eq 'cobinhood'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 10
    expect(order_book.bids.count).to be > 10
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end

end
