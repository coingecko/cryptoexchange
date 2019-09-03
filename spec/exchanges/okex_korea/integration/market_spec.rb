require 'spec_helper'

RSpec.describe 'OkexKorea integration specs' do
  let(:client) { Cryptoexchange::Client.new }

  it 'fetch pairs' do
    pairs = client.pairs('okex_korea')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'okex_korea'
  end

  it 'fetch ticker' do
    pair = Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USDT', market: 'okex_korea')
    ticker = client.ticker(pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq 'okex_korea'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    btc_usd_pair = Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USDT', market: 'okex_korea')
    order_book = client.order_book(btc_usd_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'USDT'
    expect(order_book.market).to eq 'okex_korea'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end
  
  it 'give trade url' do
    pair = Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USDT', market: 'okex_korea')
    trade_page_url = client.trade_page_url 'okex_korea', base: pair.base, target: pair.target
    expect(trade_page_url).to eq "https://okex.co.kr/kr/view/trade/order"
  end
end
