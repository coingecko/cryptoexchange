require 'spec_helper'

RSpec.describe 'Tokenomy integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:ten_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'TEN', target: 'BTC', market: 'tokenomy') }

  it 'fetch pairs' do
    pairs = client.pairs('tokenomy')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'tokenomy'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'tokenomy', base: ten_btc_pair.base, target: ten_btc_pair.target
    expect(trade_page_url).to eq "https://exchange.tokenomy.com/market/TENBTC"
  end

  it 'fetch ticker' do
    ticker = client.ticker(ten_btc_pair)

    expect(ticker.base).to eq 'TEN'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'tokenomy'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(ten_btc_pair)

    expect(order_book.base).to eq 'TEN'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'tokenomy'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be nil
    expect(order_book.bids.first.amount).to_not be nil
    expect(order_book.bids.first.timestamp).to be nil
    expect(order_book.asks.count).to_not be nil
    expect(order_book.bids.count).to_not be nil
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(ten_btc_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'TEN'
    expect(trade.target).to eq 'BTC'
    expect(trade.price).to_not be nil
    expect(trade.amount).to_not be nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'tokenomy'
  end

end
