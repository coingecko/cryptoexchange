require 'spec_helper'

RSpec.describe 'Chbtc integration specs' do
  let(:client) { Cryptoexchange::Client.new }

  it 'fetch pairs' do
    pairs = client.pairs('chbtc')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'chbtc'
  end

  it 'fetch ticker' do
    ltc_btc_pair = Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'CNY', market: 'chbtc')
    ticker = client.ticker(ltc_btc_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'CNY'
    expect(ticker.market).to eq 'chbtc'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(DateTime.strptime(ticker.timestamp.to_s, '%s').year).to eq Date.today.year
    expect(ticker.payload).to_not be nil
  end
end
