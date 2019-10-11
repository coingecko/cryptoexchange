require 'spec_helper'

RSpec.describe 'UpbitIndonesia integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'usdt', market: 'upbit_indonesia') }

  it 'fetch pairs' do
    pairs = client.pairs('upbit_indonesia')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'upbit_indonesia'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'upbit_indonesia', base: btc_usdt_pair.base, target: btc_usdt_pair.target
    expect(trade_page_url).to eq "https://id.upbit.com/exchange?code=CRIX.UPBIT.USDT-BTC"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usdt_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq 'upbit_indonesia'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
  
    expect(ticker.payload).to_not be nil
  end
end
