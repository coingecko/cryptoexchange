require 'spec_helper'

RSpec.describe 'Switcheo integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:mct_neo_pair) { Cryptoexchange::Models::MarketPair.new(base: 'MCT', target: 'NEO', market: 'switcheo') }

  it "invoke trade_page_url" do
    args = { base: "MCT", target: "NEO" }

    expect(Cryptoexchange::Exchanges::Switcheo::Market).to receive(:trade_page_url).with(args)
    client.trade_page_url('switcheo', args)
  end

  it 'fetch pairs' do
    pairs = client.pairs('switcheo')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'switcheo'
  end

  it 'fetch ticker' do
    ticker = client.ticker(mct_neo_pair)

    expect(ticker.base).to_not be 'MCT'
    expect(ticker.target).to_not be 'NEO'
    expect(ticker.market).to eq 'switcheo'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(mct_neo_pair)

    expect(order_book.base).to eq 'MCT'
    expect(order_book.target).to eq 'NEO'
    expect(order_book.market).to eq 'switcheo'

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
