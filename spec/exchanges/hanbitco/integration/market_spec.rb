require 'spec_helper'

RSpec.describe 'Hanbitco integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'hanbitco' }
  let(:eos_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'EOS', target: 'BTC', market: 'hanbitco') }

  it 'fetch pairs' do
    pairs = client.pairs('hanbitco')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'hanbitco'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: eos_btc_pair.base, target: eos_btc_pair.target
    expect(trade_page_url).to eq "https://www.hanbitco.com/exchange/eos_btc"
  end

  it 'fetch ticker' do
    ticker = client.ticker(eos_btc_pair)

    expect(ticker.base).to eq 'EOS'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'hanbitco'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(eos_btc_pair)

    expect(order_book.base).to eq 'EOS'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'hanbitco'

    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 5
    expect(order_book.bids.count).to be > 5
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end
end
