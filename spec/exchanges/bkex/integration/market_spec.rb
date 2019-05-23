require 'spec_helper'

RSpec.describe 'Bkex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:bkk_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BKK', target: 'USDT', market: 'bkex') }

  it 'fetch pairs' do
    pairs = client.pairs('bkex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bkex'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'bkex', base: bkk_usdt_pair.base, target: bkk_usdt_pair.target
    expect(trade_page_url).to eq "https://www.bkex.com/#/trade/BKK_USDT"
  end

  it 'fetch ticker' do
    ticker = client.ticker(bkk_usdt_pair)

    expect(ticker.base).to eq 'BKK'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq 'bkex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
