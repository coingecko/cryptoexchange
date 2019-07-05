require 'spec_helper'

RSpec.describe 'Eterbase integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eth_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'USDT', inst_id: 33, market: 'eterbase') }

  it 'fetch pairs' do
    pairs = client.pairs('eterbase')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to eq 'ETH'
    expect(pair.target).to eq 'USDT'
    expect(pair.market).to eq 'eterbase'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'eterbase', base: eth_usdt_pair.base, target: eth_usdt_pair.target
    expect(trade_page_url).to eq "https://eterbase.exchange/markets/ETHUSDT"
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_usdt_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq 'eterbase'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(eth_usdt_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.trade_id).to_not be_nil
    expect(trade.base).to eq 'ETH'
    expect(trade.target).to eq 'USDT'
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be nil
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'eterbase'
  end
end
