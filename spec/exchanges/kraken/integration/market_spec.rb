require 'spec_helper'

RSpec.describe 'Kraken integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'kraken' }
  let(:bch_eur_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BCH', target: 'EUR', market: 'kraken') }

  it 'fetch pairs' do
    pairs = client.pairs('kraken')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'kraken'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: bch_eur_pair.base, target: bch_eur_pair.target
    expect(trade_page_url).to eq "https://trade.kraken.com/markets/kraken/bch/eur"
  end

  it 'fetch ticker' do
    ticker = client.ticker(bch_eur_pair)

    expect(ticker.base).to eq 'BCH'
    expect(ticker.target).to eq 'EUR'
    expect(ticker.market).to eq 'kraken'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(bch_eur_pair)

    expect(order_book.base).to eq 'BCH'
    expect(order_book.target).to eq 'EUR'
    expect(order_book.market).to eq 'kraken'

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

  it 'fetch trades' do
    trades = client.trades(bch_eur_pair)
    trade = trades.first

    expect(trade.base).to eq 'BCH'
    expect(trade.target).to eq 'EUR'
    expect(trade.market).to eq 'kraken'

    expect(trade.amount).to_not be_nil
    expect(trade.price).to_not be_nil
    expect(2000..Date.today.year).to include(Time.at(trade.timestamp).year)
    expect(trade.trade_id).to be_nil
    expect(trade.type).to eq("buy").or eq("sell")
  end
end
