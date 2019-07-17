require 'spec_helper'

RSpec.describe 'Veridex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:vsf_weth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'VSF', target: 'WETH', market: 'veridex') }

  it 'fetch pairs' do
    pairs = client.pairs('veridex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'veridex'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'veridex', base: vsf_weth_pair.base, target: vsf_weth_pair.target
    expect(trade_page_url).to eq "https://dex.verisafe.io/#/erc20/?base=vsf&quote=weth"
  end

  it 'fetch ticker' do
    ticker = client.ticker(vsf_weth_pair)

    expect(ticker.base).to eq 'VSF'
    expect(ticker.target).to eq 'WETH'
    expect(ticker.market).to eq 'veridex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.last).to be < 100 # Test if number is reasonable
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
