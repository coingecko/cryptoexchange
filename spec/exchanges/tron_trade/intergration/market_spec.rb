require 'spec_helper'

RSpec.describe 'TronTrade integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:play_trx_pair) { Cryptoexchange::Models::MarketPair.new(base: 'PLAY', target: 'TRX', market: 'tron_trade') }

  it 'fetch pairs' do
    pairs = client.pairs('tron_trade')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be_nil
    expect(pair.target).to_not be_nil
    expect(pair.market).to eq 'tron_trade'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'tron_trade', base: play_trx_pair.base, target: play_trx_pair.target
    expect(trade_page_url).to eq "https://trontrade.io"
  end

  it 'fetch ticker' do
    ticker = client.ticker(play_trx_pair)

    expect(ticker.base).to eq 'PLAY'
    expect(ticker.target).to eq 'TRX'
    expect(ticker.market).to eq 'tron_trade'
    expect(ticker.last).to be_within(0.0025).of(0.0025)
    expect(ticker.low.to_f).to be_within(0.0025).of(0.0025)
    expect(ticker.high.to_f).to be_within(0.005).of(0.005)
    expect(ticker.volume).to be_within(41_416_670).of(41_416_670)
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
