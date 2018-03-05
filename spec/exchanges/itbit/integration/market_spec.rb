require 'spec_helper'

RSpec.describe 'Itbit integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:xbt_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'XBT', target: 'USD', market: 'itbit') }

  it 'fetch pairs' do
    pairs = client.pairs('itbit')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'itbit'
  end

  it 'fetch ticker' do
    ticker = client.ticker(xbt_usd_pair)

    expect(ticker.base).to eq 'XBT'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'itbit'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(xbt_usd_pair)

    expect(order_book.base).to eq 'XBT'
    expect(order_book.target).to eq 'USD'
    expect(order_book.market).to eq 'itbit'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end
end
