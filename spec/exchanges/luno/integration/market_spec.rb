require 'spec_helper'

RSpec.describe 'Luno integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:xbt_zar_pair) { Cryptoexchange::Models::MarketPair.new(base: 'XBT', target: 'ZAR', market: 'luno') }

  it 'fetch pairs' do
    pairs = client.pairs('luno')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'luno'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'luno', base: xbt_zar_pair.base, target: xbt_zar_pair.target
    expect(trade_page_url).to eq "https://www.luno.com/trade/XBTZAR"
  end

  it 'fetch ticker' do
    ticker = client.ticker(xbt_zar_pair)

    expect(ticker.base).to eq 'XBT'
    expect(ticker.target).to eq 'ZAR'
    expect(ticker.market).to eq 'luno'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_nil
    expect(ticker.low).to be_nil
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(xbt_zar_pair)

    expect(order_book.base).to eq 'XBT'
    expect(order_book.target).to eq 'ZAR'
    expect(order_book.market).to eq 'luno'

    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be >= 10
    expect(order_book.bids.count).to be >= 10
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trades' do
    trades = client.trades(xbt_zar_pair)
    trade = trades.first

    expect(trade.base).to eq 'XBT'
    expect(trade.target).to eq 'ZAR'
    expect(trade.market).to eq 'luno'

    expect(trade.amount).to_not be_nil
    expect(trade.price).to_not be_nil
    expect(2000..Date.today.year).to include(Time.at(trade.timestamp).year)
    expect(trade.trade_id).to_not be nil
    expect(trade.type).to eq("buy").or eq("sell")
  end
end
