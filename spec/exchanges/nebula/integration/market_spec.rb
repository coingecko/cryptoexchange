require 'spec_helper'

RSpec.describe 'Nebula integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:cav_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'CAV', target: 'ETH', market: 'nebula') }

  it 'fetch pairs' do
    pairs = client.pairs('nebula')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'nebula'
  end

  it 'fetch ticker' do
    ticker = client.ticker(cav_eth_pair)

    expect(ticker.base).to eq 'CAV'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'nebula'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(ticker.payload).to_not be nil
  end

  it 'fetch trades' do
    trades = client.trades(cav_eth_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'CAV'
    expect(trade.target).to eq 'ETH'
    expect(trade.market).to eq 'nebula'
    expect(trade.trade_id).to_not be_nil
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be nil
    expect(trade.amount).to_not be nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
