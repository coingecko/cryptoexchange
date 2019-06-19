require 'spec_helper'

RSpec.describe 'Huobi KR integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'huobi_kr' }
  let(:pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'KRW', market: 'huobi_kr') }

  it 'fetch pairs' do
    pairs = client.pairs('huobi_kr')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'huobi_kr'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: pair.base, target: pair.target
    expect(trade_page_url).to eq "https://www.huobi.co.kr/en-US/exchange/btc_krw/"
  end

  it 'fetch ticker' do
    ticker = client.ticker(pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'KRW'
    expect(ticker.market).to eq 'huobi_kr'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'KRW'
    expect(order_book.market).to eq 'huobi_kr'

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
    trades = client.trades(pair)
    trade = trades.first

    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'KRW'
    expect(trade.market).to eq 'huobi_kr'

    expect(trade.amount).to_not be_nil
    expect(trade.price).to_not be_nil
    expect(2000..Date.today.year).to include(Time.at(trade.timestamp).year)
    expect(trade.trade_id).to_not be_nil
    expect(trade.type).to eq("buy").or eq("sell")
  end
end
