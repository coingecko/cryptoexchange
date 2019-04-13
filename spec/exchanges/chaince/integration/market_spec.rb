require 'spec_helper'

RSpec.describe 'Chaince integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eos_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'EOS', target: 'USDT', market: 'chaince') }

  it 'has trade_page_url' do
    trade_page_url = client.trade_page_url eos_usdt_pair.market, base: eos_usdt_pair.base, target: eos_usdt_pair.target
    expect(trade_page_url).to eq "https://chaince.com/trade/eosusdt"
  end

  it 'fetch pairs' do
    pairs = client.pairs('chaince')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'chaince'
  end

  it 'fetch ticker' do
    ticker = client.ticker(eos_usdt_pair)

    expect(ticker.base).to eq 'EOS'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq 'chaince'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  # it 'fetch order book' do
  #   order_book = client.order_book(eos_usdt_pair)
  #
  #   expect(order_book.base).to eq 'EOS'
  #   expect(order_book.target).to eq 'USDT'
  #   expect(order_book.market).to eq 'chaince'
  #   expect(order_book.asks).to_not be_empty
  #   expect(order_book.bids).to_not be_empty
  #   expect(order_book.asks.first.price).to_not be_nil
  #   expect(order_book.bids.first.amount).to_not be_nil
  #   expect(order_book.bids.first.timestamp).to be_nil
  #   expect(order_book.asks.count).to be > 5
  #   expect(order_book.bids.count).to be > 5
  #   expect(order_book.timestamp).to be nil
  #   expect(order_book.payload).to_not be nil
  # end
  #
  # it 'fetch trade' do
  #   trades = client.trades(eos_usdt_pair)
  #   trade = trades.sample
  #
  #   expect(trades).to_not be_empty
  #   expect(trade.base).to eq 'EOS'
  #   expect(trade.target).to eq 'USDT'
  #   expect(trade.market).to eq 'chaince'
  #   expect(trade.trade_id).to_not be_nil
  #   expect(['buy', 'sell']).to include trade.type
  #   expect(trade.price).to_not be_nil
  #   expect(trade.amount).to_not be_nil
  #   expect(trade.timestamp).to be_a Numeric
  #   expect(2000..Date.today.year).to include(Time.at(trade.timestamp).year)
  #   expect(trade.payload).to_not be nil
  # end
end
