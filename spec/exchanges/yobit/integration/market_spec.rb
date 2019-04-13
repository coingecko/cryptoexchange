require 'spec_helper'

RSpec.describe 'Yobit integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:px_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'PX', target: 'BTC', market: 'yobit') }

  it 'fetch pairs' do
    pairs = client.pairs('yobit')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be_nil
    expect(pair.target).to_not be_nil
    expect(pair.market).to eq 'yobit'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'yobit', base: px_btc_pair.base, target: px_btc_pair.target
    expect(trade_page_url).to eq "https://yobit.net/en/trade/PX/BTC"
  end

  it 'fetch ticker' do
    ticker = client.ticker(px_btc_pair)

    expect(ticker.base).to eq 'PX'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'yobit'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
