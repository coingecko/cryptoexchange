require 'spec_helper'

RSpec.describe 'Binance integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'binance' }
  let(:btc_usdc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USDC', market: market) }

  it 'fetch pairs' do
    pairs = client.pairs(market)
    expect(pairs).not_to be_empty
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: btc_usdc_pair.base, target: btc_usdc_pair.target
    expect(trade_page_url).to eq "https://www.binance.com/trade.html?symbol=#{btc_usdc_pair.base}_#{btc_usdc_pair.target}"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usdc_pair)

    expect(ticker.base).to eq btc_usdc_pair.base
    expect(ticker.target).to eq btc_usdc_pair.target
    expect(ticker.market).to eq market

    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.contract_interval).to eq ""

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_usdc_pair)

    expect(order_book.base).to eq btc_usdc_pair.base
    expect(order_book.target).to eq btc_usdc_pair.target
    expect(order_book.market).to eq market

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
    trades = client.trades(btc_usdc_pair)
    trade = trades.first

    expect(trade.base).to eq btc_usdc_pair.base
    expect(trade.target).to eq btc_usdc_pair.target
    expect(trade.market).to eq 'binance'

    expect(trade.amount).to_not be_nil
    expect(trade.price).to_not be_nil
    expect(2000..Date.today.year).to include(Time.at(trade.timestamp).year)
    expect(trade.trade_id).to_not be_nil
    expect(trade.type).to eq("buy").or eq("sell")
  end
end
