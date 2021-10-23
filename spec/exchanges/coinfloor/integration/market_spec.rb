require 'spec_helper'

RSpec.describe 'Coinfloor integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:xbt_gbp_pair) { Cryptoexchange::Models::MarketPair.new(base: 'XBT', target: 'GBP', market: 'coinfloor') }

  it 'fetch pairs' do
    pairs = client.pairs('coinfloor')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'coinfloor'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'coinfloor', base: xbt_gbp_pair.base, target: xbt_gbp_pair.target
    expect(trade_page_url).to eq "https://coinfloor.co.uk/"
  end

  it 'fetch ticker' do
    ticker = client.ticker(xbt_gbp_pair)

    expect(ticker.base).to eq xbt_gbp_pair.base
    expect(ticker.target).to eq xbt_gbp_pair.target
    expect(ticker.market).to eq xbt_gbp_pair.market
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(xbt_gbp_pair)

    expect(order_book.base).to eq xbt_gbp_pair.base
    expect(order_book.target).to eq xbt_gbp_pair.target
    expect(order_book.market).to eq xbt_gbp_pair.market
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(xbt_gbp_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.trade_id).to_not be_nil
    expect(trade.base).to eq xbt_gbp_pair.base
    expect(trade.target).to eq xbt_gbp_pair.target
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq xbt_gbp_pair.market
  end
end
