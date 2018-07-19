require 'spec_helper'

RSpec.describe 'C2cx integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'C2CX' }
  let(:btc_eth_pair) do
    Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'ETH', market: market)
  end

  it 'fetch pairs' do
    pairs = client.pairs(market)
    expect(pairs).not_to be_empty
    hashed_pairs = pairs.map { |p| {base: p.base, target: p.target, market: p.market }}
    expect(hashed_pairs).to include({base: 'BTC', target: 'BCH', market: market})
    expect(hashed_pairs).to include({base: 'BTC', target: 'DASH', market: market})
    expect(hashed_pairs).to include({base: 'BTC', target: 'ETH', market: market})
    expect(hashed_pairs).to include({base: 'BTC', target: 'FUN', market: market})
    expect(hashed_pairs).to include({base: 'BTC', target: 'SKY', market: market})
    expect(hashed_pairs).to include({base: 'BTC', target: 'TNB', market: market})
    expect(hashed_pairs).to include({base: 'BTC', target: 'UCASH', market: market})
    expect(hashed_pairs).to include({base: 'BTC', target: 'ZRX', market: market})
    expect(hashed_pairs).to include({base: 'DRG', target: 'BCH', market: market})
    expect(hashed_pairs).to include({base: 'DRG', target: 'BTC', market: market})
    expect(hashed_pairs).to include({base: 'DRG', target: 'BTG', market: market})
    expect(hashed_pairs).to include({base: 'DRG', target: 'DASH', market: market})
    expect(hashed_pairs).to include({base: 'DRG', target: 'ETC', market: market})
    expect(hashed_pairs).to include({base: 'DRG', target: 'ETH', market: market})
    expect(hashed_pairs).to include({base: 'DRG', target: 'FUN', market: market})
    expect(hashed_pairs).to include({base: 'DRG', target: 'LTC', market: market})
    expect(hashed_pairs).to include({base: 'DRG', target: 'SKY', market: market})
    expect(hashed_pairs).to include({base: 'DRG', target: 'TNB', market: market})
    expect(hashed_pairs).to include({base: 'DRG', target: 'ZEC', market: market})
    expect(hashed_pairs).to include({base: 'DRG', target: 'ZRX', market: market})
    expect(hashed_pairs).to include({base: 'USDT', target: 'BCH', market: market})
    expect(hashed_pairs).to include({base: 'USDT', target: 'BTC', market: market})
    expect(hashed_pairs).to include({base: 'USDT', target: 'BTG', market: market})
    expect(hashed_pairs).to include({base: 'USDT', target: 'DASH', market: market})
    expect(hashed_pairs).to include({base: 'USDT', target: 'DRG', market: market})
    expect(hashed_pairs).to include({base: 'USDT', target: 'ETC', market: market})
    expect(hashed_pairs).to include({base: 'USDT', target: 'ETH', market: market})
    expect(hashed_pairs).to include({base: 'USDT', target: 'FUN', market: market})
    expect(hashed_pairs).to include({base: 'USDT', target: 'LTC', market: market})
    expect(hashed_pairs).to include({base: 'USDT', target: 'SKY', market: market})
    expect(hashed_pairs).to include({base: 'USDT', target: 'TNB', market: market})
    expect(hashed_pairs).to include({base: 'USDT', target: 'UCASH', market: market})
    expect(hashed_pairs).to include({base: 'USDT', target: 'ZEC', market: market})
    expect(hashed_pairs).to include({base: 'USDT', target: 'ZRX', market: market})
    expect(hashed_pairs).to include({base: 'DRG', target: 'OMG', market: market})
    expect(hashed_pairs).to include({base: 'BTC', target: 'OMG', market: market})
    expect(hashed_pairs).to include({base: 'DRG', target: 'RCN', market: market})
    expect(hashed_pairs).to include({base: 'BTC', target: 'RCN', market: market})
    expect(hashed_pairs).to include({base: 'DRG', target: 'XRP', market: market})
    expect(hashed_pairs).to include({base: 'BTC', target: 'XRP', market: market})
    expect(hashed_pairs).to include({base: 'DRG', target: 'EOS', market: market})
    expect(hashed_pairs).to include({base: 'BTC', target: 'EOS', market: market})
    expect(hashed_pairs).to include({base: 'DRG', target: 'WAX', market: market})
    expect(hashed_pairs).to include({base: 'BTC', target: 'WAX', market: market})
    expect(hashed_pairs).to include({base: 'DRG', target: 'XLM', market: market})
    expect(hashed_pairs).to include({base: 'BTC', target: 'XLM', market: market})
    expect(hashed_pairs).to include({base: 'BTC', target: 'ETC', market: market})
    expect(hashed_pairs).to include({base: 'BTC', target: 'LTC', market: market})
    expect(hashed_pairs).to include({base: 'BTC', target: 'BTG', market: market})
    expect(hashed_pairs).to include({base: 'BTC', target: 'ZEC', market: market})
    expect(hashed_pairs).to include({base: 'BTC', target: 'TRIA', market: market})
    expect(hashed_pairs).to include({base: 'BTC', target: 'BEZ', market: market})
    expect(hashed_pairs).to include({base: 'BTC', target: 'SLRM', market: market})
    expect(hashed_pairs).to include({base: 'USDT', target: 'OMG', market: market})
    expect(hashed_pairs).to include({base: 'USDT', target: 'RCN', market: market})
    expect(hashed_pairs).to include({base: 'USDT', target: 'XRP', market: market})
    expect(hashed_pairs).to include({base: 'USDT', target: 'EOS', market: market})
    expect(hashed_pairs).to include({base: 'USDT', target: 'WAX', market: market})
    expect(hashed_pairs).to include({base: 'USDT', target: 'XLM', market: market})
  end


  it 'fetch ticker' do
    ticker = client.ticker(btc_eth_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq market
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_eth_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'ETH'
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
