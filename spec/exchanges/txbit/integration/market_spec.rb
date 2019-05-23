require 'spec_helper'

RSpec.describe 'Txbit integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'txbit' }
  let(:eth_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'eth', target: 'btc', market: 'txbit') }

  it 'fetch pairs' do
    pairs = client.pairs('txbit')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'txbit'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, target: eth_btc_pair.target, base: eth_btc_pair.base
    expect(trade_page_url).to eq "https://txbit.io/Trade/ETH/BTC"
  end

  it 'fetch pairs and assign the correct base/target' do
    pairs = client.pairs('txbit')
    expect(pairs).not_to be_empty
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_btc_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'txbit'
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fail to parse ticker' do
    expect { client.ticker(Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'xxxxx', market: 'txbit')) }.to raise_error(Cryptoexchange::ResultParseError)
  end

  it 'fetch order book' do
    order_book = client.order_book(eth_btc_pair)

    expect(order_book.base).to eq 'ETH'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'txbit'

    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 5
    expect(order_book.bids.count).to be > 5
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end
end
