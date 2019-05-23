require 'spec_helper'

RSpec.describe 'Escodex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'escodex' }
  let(:lpc_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'LPC', target: 'BTC', market: 'escodex') }

  it 'fetch pairs' do
    pairs = client.pairs('escodex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'escodex'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: lpc_btc_pair.base, target: lpc_btc_pair.target
    expect(trade_page_url).to eq "https://wallet.escodex.com/market/ESCODEX.LPC_ESCODEX.BTC"
  end

  it 'fetch ticker' do
    ticker = client.ticker(lpc_btc_pair)

    expect(ticker.base).to eq 'LPC'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'escodex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
