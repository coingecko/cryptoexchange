require 'spec_helper'

RSpec.describe 'Waves integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:vtn_waves_pair) { Cryptoexchange::Models::MarketPair.new(base: 'VTN', target: 'WAVES', market: 'waves') }

  it 'fetch pairs' do
    pairs = client.pairs('waves')
    expect(pairs).not_to be_empty

    pair = pairs.sample
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'waves'
  end

  it 'fetch ticker' do
    ticker = client.ticker(vtn_waves_pair)

    expect(ticker.base).to eq 'VTN'
    expect(ticker.target).to eq 'WAVES'
    expect(ticker.market).to eq 'waves'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(vtn_waves_pair)
    trade  = trades.sample

    expect(trades).to_not be_empty
    expect(trade.trade_id).to_not be_nil
    expect(trade.base).to eq 'VTN'
    expect(trade.target).to eq 'WAVES'
    expect(trade.trade_id).to_not be nil
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be nil
    expect(trade.amount).to_not be nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'waves'
  end

end
