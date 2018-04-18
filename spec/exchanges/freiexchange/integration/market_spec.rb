require 'spec_helper'

RSpec.describe 'Freiexchange integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:anc_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ANC', target: 'BTC', market: 'freiexchange') }

  it 'fetch pairs' do
    pairs = client.pairs('freiexchange')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'freiexchange'
  end

  it 'fetch ticker' do
    ticker = client.ticker(anc_btc_pair)

    expect(ticker.base).to eq 'ANC'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'freiexchange'
    expect(ticker.volume).to be_a Numeric    
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.last).to be_a Numeric    
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(anc_btc_pair)

    expect(order_book.base).to eq 'ANC'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'freiexchange'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end
end
