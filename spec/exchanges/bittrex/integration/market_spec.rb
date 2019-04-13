require 'spec_helper'

RSpec.describe 'Bittrex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'bittrex' }
  let(:ltc_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ltc', target: 'btc', market: 'bittrex') }

  it 'fetch pairs' do
    pairs = client.pairs('bittrex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bittrex'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: ltc_btc_pair.base, target: ltc_btc_pair.target
    expect(trade_page_url).to eq "https://bittrex.com/Market/Index?MarketName=BTC-LTC"
  end

  it 'fetch pairs and assign the correct base/target' do
    pairs = client.pairs('bittrex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to eq 'LTC'
    expect(pair.target).to eq 'BTC'
    expect(pair.market).to eq 'bittrex'
  end

  it 'fetch ticker' do
    ticker = client.ticker(ltc_btc_pair)

    expect(ticker.base).to eq 'LTC'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'bittrex'
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fail to parse ticker' do
    expect { client.ticker(Cryptoexchange::Models::MarketPair.new(base: 'ingt', target: 'btc', market: 'bittrex')) }.to raise_error(Cryptoexchange::ResultParseError)
  end
end
