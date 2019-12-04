require 'spec_helper'

RSpec.describe 'Citex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'citex' }
  let(:veil_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'VEIL', target: 'BTC', market: 'citex') }

  it 'fetch pairs' do
    pending "Skip this test due to restriction"

    pairs = client.pairs('citex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'citex'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'citex', base: veil_btc_pair.base, target: veil_btc_pair.target
    expect(trade_page_url).to eq "https://trade.citex.co.kr/trade/VEIL_BTC"
  end  

  it 'fetch ticker' do
    pending "Skip this test due to restriction"

    ticker = client.ticker(veil_btc_pair)

    expect(ticker.base).to eq 'VEIL'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'citex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    pending "Skip this test due to restriction"
    
    order_book = client.order_book(veil_btc_pair)

    expect(order_book.base).to eq 'VEIL'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'citex'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.timestamp).to be nil
    expect(order_book.payload).to_not be nil
  end
end
