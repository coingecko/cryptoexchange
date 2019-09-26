require 'spec_helper'

RSpec.describe 'Coinflex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:xbt_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'XBT', target: 'USDT', inst_id: '63488:65283', contract_interval: 'perpetual', market: 'coinflex') }

  it 'fetch pairs' do
    pairs = client.pairs('coinflex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.contract_interval).to eq 'perpetual'
    expect(pair.inst_id).to_not be nil
    expect(pair.market).to eq 'coinflex'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'coinflex', base: xbt_usdt_pair.base, target: xbt_usdt_pair.target
    expect(trade_page_url).to eq "https://coinflex-preview.trade.tt/live/preview"
  end

  it 'fetch ticker' do
    ticker = client.ticker(xbt_usdt_pair)

    expect(ticker.base).to eq xbt_usdt_pair.base
    expect(ticker.target).to eq xbt_usdt_pair.target
    expect(ticker.contract_interval).to eq xbt_usdt_pair.contract_interval
    expect(ticker.market).to eq xbt_usdt_pair.market
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(xbt_usdt_pair)

    expect(order_book.base).to eq xbt_usdt_pair.base
    expect(order_book.target).to eq xbt_usdt_pair.target
    expect(order_book.market).to eq xbt_usdt_pair.market
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end

  it 'fetch contract stat' do
    contract_stat = client.contract_stat(xbt_usdt_pair)

    expect(contract_stat.base).to eq 'XBT'
    expect(contract_stat.target).to eq 'USDT'
    expect(contract_stat.market).to eq 'coinflex'
    expect(contract_stat.index).to be nil
    expect(contract_stat.open_interest).to be_a Numeric
    expect(contract_stat.timestamp).to be nil

    expect(contract_stat.payload).to_not be nil
  end
end
