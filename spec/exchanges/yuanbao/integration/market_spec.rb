require 'spec_helper'

RSpec.describe 'Yuanbao integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_cny_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'CNY', market: 'yuanbao') }

  it 'fetch pairs' do
    pairs = client.pairs('yuanbao')


    expected_base = %w(BTC NEO XRP ETH QTUM DCT XLM ABC LTC ETC DOGE YBC ZEC FCT TMC XSI NAS LEC MCC EOS XAS SMC LMC GAME SHC ARC XKC MXI YBY BASH MC UDB MRYC RHKC BTE JC CIC GP AXF GOOC VASH)

    expect(pairs.map(&:base)).to match_array expected_base
    expect(pairs.map(&:target).uniq).to eq %w(CNY)
    expect(pairs.map(&:market).uniq).to eq %w(yuanbao)
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_cny_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'CNY'
    expect(ticker.market).to eq 'yuanbao'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
