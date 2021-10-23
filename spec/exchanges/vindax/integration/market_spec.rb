require 'spec_helper'

RSpec.describe 'Vindax integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:bnb_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BNB', target: 'ETH', market: 'vindax') }

  it 'fetch pairs' do
    pairs = client.pairs('vindax')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'vindax'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url bnb_eth_pair.market, base: bnb_eth_pair.base, target: bnb_eth_pair.target
    expect(trade_page_url).to eq "https://vindax.com/exchange-base.html?symbol=BNB_ETH"
  end

  it 'fetch ticker' do
    ticker = client.ticker(bnb_eth_pair)

    expect(ticker.base).to eq 'BNB'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'vindax'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(bnb_eth_pair)

    expect(order_book.base).to eq 'BNB'
    expect(order_book.target).to eq 'ETH'
    expect(order_book.market).to eq 'vindax'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 0
    expect(order_book.bids.count).to be > 0
    expect(order_book.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(order_book.timestamp).year)
    expect(order_book.payload).to_not be nil
  end
end
