require 'spec_helper'

RSpec.describe 'GoExchange integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_usdc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USDC', market: 'go_exchange') }

  it 'fetch pairs' do
    pairs = client.pairs('go_exchange')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'go_exchange'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'go_exchange', base: btc_usdc_pair.base, target: btc_usdc_pair.target
    expect(trade_page_url).to eq "https://trade.go.exchange/en/trade/BTCUSDC"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usdc_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USDC'
    expect(ticker.market).to eq 'go_exchange'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_usdc_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'USDC'
    expect(order_book.market).to eq 'go_exchange'

    expect(order_book.asks).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.asks.first.amount).to_not be_nil
    expect(order_book.asks.first.timestamp).to be_nil

    expect(order_book.bids).to_not be_empty
    expect(order_book.bids.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil

    expect(order_book.timestamp).to be nil
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(btc_usdc_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'USDC'
    expect(trade.market).to eq 'go_exchange'
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
