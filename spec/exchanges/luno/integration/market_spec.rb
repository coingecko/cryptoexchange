require 'spec_helper'

RSpec.describe 'Luno integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:xbt_zar_pair) { Cryptoexchange::Models::MarketPair.new(base: 'XBT', target: 'ZAR', market: 'luno') }

  it 'fetch pairs' do
    pairs = client.pairs('luno')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'luno'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'luno', base: xbt_zar_pair.base, target: xbt_zar_pair.target
    expect(trade_page_url).to eq "https://www.luno.com/trade/XBTZAR"
  end

  it 'fetch ticker' do
    ticker = client.ticker(xbt_zar_pair)

    expect(ticker.base).to eq 'XBT'
    expect(ticker.target).to eq 'ZAR'
    expect(ticker.market).to eq 'luno'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_nil
    expect(ticker.low).to be_nil
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
