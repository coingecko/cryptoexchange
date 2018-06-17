require 'spec_helper'

RSpec.describe 'Joyso integration specs' do
  client = Cryptoexchange::Client.new
  let(:usdt_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'usdt', target: 'eth', market: 'joyso') }

  it 'fetch pairs' do
    pairs = client.pairs('joyso')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'joyso'
  end

  it 'fetch ticker' do
    ticker = client.ticker(usdt_eth_pair)

    expect(ticker.base).to eq 'USDT'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'joyso'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(usdt_eth_pair)

    expect(order_book.base).to eq 'USDT'
    expect(order_book.target).to eq 'ETH'
    expect(order_book.market).to eq 'joyso'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.count).to be > 0
    expect(order_book.bids.count).to be > 0
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end
end
