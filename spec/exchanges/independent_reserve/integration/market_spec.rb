require 'spec_helper'

RSpec.describe 'IndependentReserve Coin integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'independent_reserve' }
  let(:eth_aud_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'AUD', market: 'independent_reserve') }

  it 'fetch pairs' do
    pairs = client.pairs('independent_reserve')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'independent_reserve'
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_aud_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'AUD'
    expect(ticker.market).to eq 'independent_reserve'
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: eth_aud_pair.base
    expect(trade_page_url).to eq "https://www.independentreserve.com/market#eth"
  end

  it 'fetch order book' do
    order_book = client.order_book(eth_aud_pair)

    expect(order_book.base).to eq 'ETH'
    expect(order_book.target).to eq 'AUD'
    expect(order_book.market).to eq 'independent_reserve'

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
