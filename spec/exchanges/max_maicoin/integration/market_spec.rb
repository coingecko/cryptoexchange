require 'spec_helper'

RSpec.describe 'MaxMaicoin integration specs' do
  let(:client) { Cryptoexchange::Client.new }

  it 'fetch pairs' do
    pairs = client.pairs('max_maicoin')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'max_maicoin'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'max_maicoin', base: 'BTC', target: 'TWD'
    expect(trade_page_url).to eq "https://max.maicoin.com/markets/btctwd"
  end

  it 'fetch ticker' do
    btc_twd_pair = Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'TWD', market: 'max_maicoin')
    ticker = client.ticker(btc_twd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'TWD'
    expect(ticker.market).to eq 'max_maicoin'
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    btc_twd_pair = Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'TWD', market: 'max_maicoin')
    order_book = client.order_book(btc_twd_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'TWD'
    expect(order_book.market).to eq 'max_maicoin'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    btc_twd_pair = Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'TWD', market: 'max_maicoin')
    trades = client.trades(btc_twd_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'TWD'
    expect(trade.market).to eq 'max_maicoin'
    expect(trade.trade_id).to_not be_nil
    expect(trade.type).to_not be_nil
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(trade.timestamp).year)
    expect(trade.payload).to_not be nil

  end
end
