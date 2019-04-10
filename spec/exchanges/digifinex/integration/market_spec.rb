require 'spec_helper'

RSpec.describe 'Digifinex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:usdt_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'USDT', target: 'BTC', market: 'digifinex') }

  it 'fetch pairs' do
    pairs = client.pairs('digifinex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'digifinex'
  end

  it 'fetch ticker' do
    ticker = client.ticker(usdt_btc_pair)

    expect(ticker.base).to eq 'USDT'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'digifinex'

    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.change).to be_a Numeric

    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
