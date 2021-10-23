require 'spec_helper'

RSpec.describe 'Idcm Coin integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eos_vusd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'EOS', target: 'VUSD', market: 'idcm') }

  it 'fetch pairs' do
    pairs = client.pairs('idcm')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'idcm'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'idcm', base: eos_vusd_pair.base, target: eos_vusd_pair.target
    expect(trade_page_url).to eq "https://www.idcm.io/trading/EOS_VUSD"
  end

  it 'fetch ticker' do
    ticker = client.ticker(eos_vusd_pair)

    expect(ticker.base).to eq 'EOS'
    expect(ticker.target).to eq 'VUSD'
    expect(ticker.market).to eq 'idcm'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(eos_vusd_pair)

    expect(order_book.base).to eq 'EOS'
    expect(order_book.target).to eq 'VUSD'
    expect(order_book.market).to eq 'idcm'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 0
    expect(order_book.bids.count).to be > 0
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end
end
