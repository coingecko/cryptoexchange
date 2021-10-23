require 'spec_helper'

RSpec.describe 'Localbitcoins integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'localbitcoins' }
  let(:btc_myr_pair) do
    Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'MYR', market: market)
  end

  it 'fetch pairs' do
    pairs = client.pairs(market)
    hashed_pairs = pairs.map { |p| {base: p.base, target: p.target, market: p.market, contract_interval: p.contract_interval }}
    expect(pairs).not_to be_empty
    expect(hashed_pairs).to include({base: 'BTC', target: 'SGD', market: market, contract_interval: ""})
    expect(hashed_pairs).to include({base: 'BTC', target: 'MYR', market: market, contract_interval: ""})
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: btc_myr_pair.base, target: btc_myr_pair.target
    expect(trade_page_url).to eq "https://localbitcoins.com"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_myr_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'MYR'
    expect(ticker.market).to eq market

    expect(ticker.bid).to be nil
    expect(ticker.ask).to be nil
    expect(ticker.volume).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.contract_interval).to eq ""
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch trades' do
    trades = client.trades(btc_myr_pair)
    trade = trades.first

    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'MYR'
    expect(trade.market).to eq market

    expect(trade.amount).to_not be_nil
    expect(trade.price).to_not be_nil
    expect(trade.timestamp).to_not be_nil
    expect(trade.trade_id).to_not be_nil
    expect(trade.type).to be nil
  end
end
