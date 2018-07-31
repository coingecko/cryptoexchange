require 'spec_helper'

RSpec.describe 'TrocaNinja integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_brl_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'BRL', market: 'troca_ninja') }

  it 'fetch pairs' do
    pairs = client.pairs('troca_ninja')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be_nil
    expect(pair.target).to_not be_nil
    expect(pair.market).to eq 'troca_ninja'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_brl_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'BRL'
    expect(ticker.market).to eq 'troca_ninja'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
