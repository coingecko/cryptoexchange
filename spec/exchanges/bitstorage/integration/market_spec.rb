require 'spec_helper'

RSpec.describe 'BitStorage integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'bitstorage') }

  it 'has trade_page_url' do
    trade_page_url = client.trade_page_url btc_usd_pair.market, base: btc_usd_pair.base, target: btc_usd_pair.target
    expect(trade_page_url).to eq "https://bitstorage.finance/market/BTC-USD"
  end

  it 'fetch pairs' do
    pairs = client.pairs('bitstorage')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bitstorage'
  end

    it 'fetch ticker' do
      ticker = client.ticker(btc_usd_pair)

      expect(ticker.base).to eq 'BTC'
      expect(ticker.target).to eq 'USD'
      expect(ticker.market).to eq 'bitstorage'
      expect(ticker.last).to be_a Numeric
      expect(ticker.volume).to be_a Numeric
      expect(ticker.timestamp).to be nil
      expect(ticker.payload).to_not be nil
    end

  it 'fetch order book' do
    order_book = client.order_book(btc_usd_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'USD'
    expect(order_book.market).to eq 'bitstorage'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.count).to be > 0
    expect(order_book.bids.count).to be > 0
    expect(order_book.timestamp).to be nil
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(btc_usd_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'USD'
    expect(trade.market).to eq 'bitstorage'
    expect(trade.trade_id).to_not be_nil
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_nil
    expect(trade.payload).to_not be nil
  end
end
