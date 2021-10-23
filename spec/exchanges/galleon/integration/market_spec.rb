require 'spec_helper'

RSpec.describe 'Galleon integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:grin_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'GRIN', target: 'BTC', market: 'galleon') }

  it 'fetch pairs' do
    pairs = client.pairs('galleon')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'galleon'
  end

  it 'fetch ticker' do
    ticker = client.ticker(grin_btc_pair)

    expect(ticker.base).to eq 'GRIN'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'galleon'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'galleon', base: grin_btc_pair.base, target: grin_btc_pair.target
    expect(trade_page_url).to eq "https://galleon.exchange/trading/grinbtc"
  end
end
