require 'spec_helper'

RSpec.describe 'Binance integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'binance' }
  let(:btc_eur_pair) do
    Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'BTC', market: market)
  end

  it 'fetch pairs' do
    pairs = client.pairs(market)
    expect(pairs).not_to be_empty
    hashed_pairs = pairs.map { |p| {base: p.base, target: p.target, market: p.market, contract_interval: p.contract_interval }}
    expect(hashed_pairs).to include({base: 'ETH', target: 'BTC', market: market, contract_interval: ""})
    expect(hashed_pairs).to include({base: 'ETH', target: 'USDT', market: market, contract_interval: ""})
    expect(hashed_pairs).to include({base: 'LSK', target: 'BNB', market: market, contract_interval: ""})
    expect(hashed_pairs).to include({base: 'QTUM', target: 'ETH', market: market, contract_interval: ""})
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: btc_eur_pair.base, target: btc_eur_pair.target
    expect(trade_page_url).to eq "https://www.binance.com/trade.html?symbol=ETH_BTC"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_eur_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq market

    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(ticker.contract_interval).to eq ""
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_eur_pair)

    expect(order_book.base).to eq 'ETH'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq market

    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to_not be_nil
    expect(order_book.asks.count).to be > 10
    expect(order_book.bids.count).to be > 10
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end
end
