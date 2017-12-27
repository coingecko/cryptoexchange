require 'spec_helper'

RSpec.describe 'Lykke integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'lykke' }
  let(:eth_btc_pair) do
    Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'BTC', market: market)
  end

  it 'fetch pairs' do
    pairs = client.pairs(market)
    expect(pairs).not_to be_empty
    hashed_pairs = pairs.map { |p| {base: p.base, target: p.target, market: p.market }}
    expect(hashed_pairs).to include({base: 'ETH', target: 'BTC', market: market})
    expect(hashed_pairs).to include({base: 'LKK1Y', target: 'USD', market: market})
    expect(hashed_pairs).to include({base: 'BTC', target: 'LKK1Y', market: market})
    expect(hashed_pairs).to include({base: 'TIME', target: 'GBP', market: market})
    expect(hashed_pairs).to include({base: 'SHEELA', target: 'EUR', market: market})
    expect(hashed_pairs).not_to include({base: '91316bdc-f379-4442-98fd-f2c844995ca1', target: 'CHF', market: market})
    expect(hashed_pairs).not_to include({base: 'USD', target: 'GB032548', market: market})
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_btc_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq market

    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(DateTime.strptime(ticker.timestamp.to_s, '%s').year).to eq Date.today.year
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(eth_btc_pair)

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
