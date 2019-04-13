require 'spec_helper'

RSpec.describe 'BitboxPrivate integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:xrp_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'xrp', target: 'btc', market: 'bitbox') }
  let(:filename) { Cryptoexchange::Credentials.send(:filename) }

  before do
    allow(Cryptoexchange::Credentials).to receive(:get).with('bitbox_private').and_return({ 'api_key' => 'blah', 'api_secret' => 'blah' })
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'bitbox_private', base: xrp_btc_pair.base, target: xrp_btc_pair.target
    expect(trade_page_url).to eq "https://www.bitbox.me/exchange?coin=XRP&market=BTC"
  end

  it 'fetch pairs' do
    pairs = client.pairs('bitbox_private')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bitbox_private'
  end

  it 'fetch ticker' do
    pending "Skip this test due to restriction"
    fail
    ticker = client.ticker(xrp_btc_pair)

    expect(ticker.base).to eq 'XRP'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'bitbox_private'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
