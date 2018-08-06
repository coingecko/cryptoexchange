require 'spec_helper'

RSpec.describe 'F1cx integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:mtc_ltc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'MTC', target: 'LTC', market: 'f1cx') }

  it 'fetch pairs' do
    pairs = client.pairs('f1cx')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'f1cx'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'f1cx', base: mtc_ltc_pair.base, target: mtc_ltc_pair.target
    expect(trade_page_url).to eq "https://f1cx.com/markets/MTCLTC"
  end

  it 'fetch ticker' do
    ticker = client.ticker(mtc_ltc_pair)

    expect(ticker.base).to eq 'MTC'
    expect(ticker.target).to eq 'LTC'
    expect(ticker.market).to eq 'f1cx'
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(mtc_ltc_pair)

    expect(order_book.base).to eq 'MTC'
    expect(order_book.target).to eq 'LTC'
    expect(order_book.market).to eq 'f1cx'
    expect(order_book.asks).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.asks.first.amount).to_not be_nil
    expect(order_book.bids).to_not be_empty
    expect(order_book.bids.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(mtc_ltc_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.trade_id).to_not be_nil
    expect(trade.base).to eq 'MTC'
    expect(trade.target).to eq 'LTC'
    expect(trade.market).to eq 'f1cx'
    expect(trade.price).to_not be_nil
    expect(trade.market).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
