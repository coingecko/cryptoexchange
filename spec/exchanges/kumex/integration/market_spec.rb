require 'spec_helper'

RSpec.describe 'Kumex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:xbt_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'XBT', target: 'USD', inst_id: "XBTUSDM", contract_interval: 'perpetual', market: 'kumex') }

  it 'fetch pairs' do
    pairs = client.pairs('kumex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.contract_interval).to eq 'perpetual'
    expect(pair.market).to eq 'kumex'
    expect(pair.inst_id).to eq 'XBTUSDM'
  end

  it 'fetch ticker' do
    ticker = client.ticker(xbt_usd_pair)

    expect(ticker.base).to eq 'XBT'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'kumex'
    expect(ticker.contract_interval).to eq 'perpetual'
    expect(ticker.inst_id).to eq 'XBTUSDM'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(xbt_usd_pair)

    expect(order_book.base).to eq 'XBT'
    expect(order_book.target).to eq 'USD'
    expect(order_book.market).to eq 'kumex'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 0
    expect(order_book.bids.count).to be > 0
    expect(order_book.timestamp).to be nil
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(xbt_usd_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.trade_id).to_not be nil
    expect(trade.base).to eq 'XBT'
    expect(trade.target).to eq 'USD'
    expect(trade.type).to eq("buy").or eq("sell")
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'kumex'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'kumex', base: xbt_usd_pair.base, target: xbt_usd_pair.target, inst_id: xbt_usd_pair.inst_id
    expect(trade_page_url).to eq "https://www.kumex.com/trade/index/XBTUSDM"
  end
end
