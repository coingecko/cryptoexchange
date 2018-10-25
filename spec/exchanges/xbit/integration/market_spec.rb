require 'spec_helper'

RSpec.describe 'Xbit integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:usd_wco_pair) { Cryptoexchange::Models::MarketPair.new(base: 'USD', target: 'WCO', market: 'xbit') }

  it 'fetch pairs' do
    pairs = client.pairs('xbit')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'xbit'
  end

  it 'fetch ticker' do
    ticker = client.ticker(usd_wco_pair)

    expect(ticker.base).to eq 'USD'
    expect(ticker.target).to eq 'WCO'
    expect(ticker.market).to eq 'xbit'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(usd_wco_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'USD'
    expect(trade.target).to eq 'WCO'
    expect(trade.price).to_not be nil
    expect(trade.amount).to_not be nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'xbit'
  end
end
