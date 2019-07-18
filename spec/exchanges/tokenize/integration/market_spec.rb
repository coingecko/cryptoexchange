require 'spec_helper'

RSpec.describe 'Tokenize integration specs' do
  client = Cryptoexchange::Client.new
  let(:btc_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'eth', target: 'btc', market: 'tokenize') }

  it 'fetch pairs' do
    pairs = client.pairs('tokenize')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'tokenize'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_eth_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'tokenize'

    expect(ticker.volume).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric

    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'tokenize', base: btc_eth_pair.base, target: btc_eth_pair.target
    expect(trade_page_url).to eq "https://tokenize.exchange/market/BTC-ETH"
  end

it 'fetch order book' do
    order_book = client.order_book(btc_eth_pair)

    expect(order_book.base).to eq 'ETH'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'tokenize'

    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end    
end
