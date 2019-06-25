require 'spec_helper'

RSpec.describe 'BinanceJersey integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'binance_jersey' }
  let(:btc_eur_pair) do
    Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'GBP', market: market)
  end

  it 'fetch pairs' do
    pairs = client.pairs(market)
    expect(pairs).not_to be_empty
    hashed_pairs = pairs.map { |p| {base: p.base, target: p.target, market: p.market }}
    expect(hashed_pairs).to include({base: 'BTC', target: 'GBP', market: market})
    expect(hashed_pairs).to include({base: 'ETH', target: 'GBP', market: market})
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: btc_eur_pair.base, target: btc_eur_pair.target
    expect(trade_page_url).to eq "https://www.binance.je/trade.html?symbol=BTC_GBP"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_eur_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'GBP'
    expect(ticker.market).to eq market

    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_eur_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'GBP'
    expect(order_book.market).to eq market

    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to_not be_nil
    expect(order_book.asks.count).to be > 10
    expect(order_book.bids.count).to be > 10
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end
end
