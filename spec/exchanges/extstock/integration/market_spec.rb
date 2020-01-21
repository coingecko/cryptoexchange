require 'spec_helper'

RSpec.describe 'Extstock integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'extstock') }

  it 'fetch pairs' do
    pairs = client.pairs('extstock')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'extstock'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'extstock', base: btc_usd_pair.base, target: btc_usd_pair.target
    expect(trade_page_url).to eq "https://extstock.com/markets/BTC_USD"
  end

  it 'fetch pairs and assign the correct base/target' do
    pairs = client.pairs('extstock')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'extstock'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'extstock'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order_book' do
    order_book = client.order_book(btc_usd_pair)

    expect(order_book.base).to eq btc_usd_pair.base
    expect(order_book.target).to eq btc_usd_pair.target
    expect(order_book.market).to eq btc_usd_pair.market
    expect(order_book.asks).to be_a Array
    expect(order_book.bids).to be_a Array
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trades' do
    trades = client.trades(btc_usd_pair)
    first_trade_result = trades.first

    expect(first_trade_result.trade_id).to_not be nil
    expect(first_trade_result.base).to eq btc_usd_pair.base
    expect(first_trade_result.target).to eq btc_usd_pair.target
    expect(first_trade_result.market).to eq btc_usd_pair.market
    # response['side'] is always returning nil currently seems like a bug from ExtStock
    # expect(first_trade_result.type).to_not be nil
    expect(first_trade_result.price).to_not be nil
  end
end
