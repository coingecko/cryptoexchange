require 'spec_helper'

RSpec.describe 'Axnet integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:tusd_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'TUSD', target: 'ETH', market: 'axnet') }

  it 'fetch pairs' do
    pairs = client.pairs('axnet')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'axnet'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'axnet', base: tusd_eth_pair.base, target: tusd_eth_pair.target
    expect(trade_page_url).to eq "https://dex.ax.net/TUSD_ETH" #"http://52.52.32.26/TUSD_ETH"
  end

  it 'fetch ticker' do
    ticker = client.ticker(tusd_eth_pair)

    expect(ticker.base).to eq 'TUSD'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'axnet'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(tusd_eth_pair)

    expect(order_book.base).to eq 'TUSD'
    expect(order_book.target).to eq 'ETH'
    expect(order_book.market).to eq 'axnet'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 0
    expect(order_book.bids.count).to be > 0
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(tusd_eth_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.trade_id).to be_nil
    expect(trade.base).to eq 'TUSD'
    expect(trade.target).to eq 'ETH'
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'axnet'
  end

end
