require 'spec_helper'

RSpec.describe 'Yunbi integration specs' do
  let(:client) { Cryptoexchange::Client.new }

  it 'fetch pairs' do
    pairs = client.pairs('yunbi')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be_nil
    expect(pair.target).to_not be_nil
    expect(pair.market).to eq 'yunbi'
  end

  it 'fetch ticker' do
    pair = Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'CNY', market: 'yunbi')
    ticker = client.ticker(pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'CNY'
    expect(ticker.market).to eq 'yunbi'
    expect(ticker.last).to_not be nil
    expect(ticker.bid).to_not be nil
    expect(ticker.ask).to_not be nil
    expect(ticker.high).to_not be nil
    expect(ticker.volume).to_not be nil
    expect(ticker.timestamp).to be_a Numeric
    expect(DateTime.strptime(ticker.timestamp.to_s, '%s').year).to eq Date.today.year
    expect(ticker.payload).to_not be nil
  end
end
