require 'spec_helper'

RSpec.describe 'Aphelion integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:aph_neo_pair) { Cryptoexchange::Models::MarketPair.new(base: 'APH', target: 'NEO', market: 'aphelion') }

  it 'fetch pairs' do
    pairs = client.pairs('aphelion')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'aphelion'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'aphelion'
    expect(trade_page_url).to eq "http://mainnet.aphelion-neo.com"
  end

  it 'fetch ticker' do
    ticker = client.ticker(aph_neo_pair)

    expect(ticker.base).to eq 'APH'
    expect(ticker.target).to eq 'NEO'
    expect(ticker.market).to eq 'aphelion'
    expect(ticker.last).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_nil
    expect(ticker.payload).to_not be nil
  end

  # it 'fetch order book' do
  #   order_book = client.order_book(aph_neo_pair)
  #
  #   expect(order_book.base).to eq 'NEO'
  #   expect(order_book.target).to eq 'APH'
  #   expect(order_book.market).to eq 'aphelion'
  #   expect(order_book.asks).to_not be_empty
  #   expect(order_book.bids).to_not be_empty
  #   expect(order_book.asks.first.price).to_not be_nil
  #   expect(order_book.bids.first.amount).to_not be_nil
  #   expect(order_book.bids.first.timestamp).to be_nil
  #   expect(order_book.asks.count).to be > 10
  #   expect(order_book.bids.count).to be > 10
  #   expect(order_book.timestamp).to be_a Numeric
  #   expect(order_book.payload).to_not be nil
  # end
  #
  # it 'fetch trade' do
  #   trades = client.trades(aph_neo_pair)
  #   trade = trades.sample
  #
  #   expect(trades).to_not be_empty
  #   expect(trade.base).to eq 'NEO'
  #   expect(trade.target).to eq 'APH'
  #   expect(trade.market).to eq 'aphelion'
  #   expect(trade.trade_id).to_not be_nil
  #   expect(['buy', 'sell']).to include trade.type
  #   expect(trade.price).to_not be_nil
  #   expect(trade.amount).to_not be_nil
  #   expect(trade.timestamp).to be_a Numeric
  #   expect(trade.payload).to_not be nil
  # end
end
