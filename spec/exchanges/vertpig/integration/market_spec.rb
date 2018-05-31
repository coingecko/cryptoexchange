require 'spec_helper'

RSpec.describe 'Vertpig integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:vtc_eur_pair) { Cryptoexchange::Models::MarketPair.new(base: 'VTC', target: 'EUR', market: 'vertpig') }

  it 'fetch pairs' do
    pairs = client.pairs('vertpig')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'vertpig'
  end

  it 'fetch ticker' do
    ticker = client.ticker(vtc_eur_pair)

    expect(ticker.base).to eq 'VTC'
    expect(ticker.target).to eq 'EUR'
    expect(ticker.market).to eq 'vertpig'
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(vtc_eur_pair)
    expect(order_book.base).to eq 'VTC'
    expect(order_book.target).to eq 'EUR'
    expect(order_book.market).to eq 'vertpig'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end
end
