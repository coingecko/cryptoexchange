require 'spec_helper'

RSpec.describe 'Etorox integration specs' do
  client = Cryptoexchange::Client.new
  let(:market) { 'etorox' }
  let(:btc_usdex_pair) { Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'usdex', market: 'etorox', inst_id: "btcusdex") }

  it 'fetch pairs' do
    pairs = client.pairs('etorox')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'etorox'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: btc_usdex_pair.base, target: btc_usdex_pair.target
    expect(trade_page_url).to eq "https://www.etorox.com/exchange/btc-usdex"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usdex_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USDEX'
    expect(ticker.market).to eq 'etorox'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_usdex_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'USDEX'
    expect(order_book.market).to eq 'etorox'

    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 10
    expect(order_book.bids.count).to be > 10
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(btc_usdex_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'USDEX'
    expect(trade.market).to eq 'etorox'
    expect(trade.trade_id).to_not be_nil
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
