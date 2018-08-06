require 'spec_helper'

RSpec.describe 'Syex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:sy_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'SY', target: 'USDT', market: 'syex') }

  it 'fetch pairs' do
    pairs = client.pairs('syex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'syex'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'syex', base: sy_usdt_pair.base, target: sy_usdt_pair.target
    expect(trade_page_url).to eq "https://www.syex.io/#/tradeCenter?payCoinName=USDT&coinName=SY"
  end

  it 'fetch ticker' do
    ticker = client.ticker(sy_usdt_pair)

    expect(ticker.base).to eq 'SY'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq 'syex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
