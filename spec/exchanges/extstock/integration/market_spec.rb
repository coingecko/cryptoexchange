require 'spec_helper'

RSpec.describe 'Extstock integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eth_ltc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'LTC', market: 'extstock') }

  it 'fetch pairs' do
    pairs = client.pairs('extstock')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'extstock'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'extstock', base: eth_ltc_pair.base, target: eth_ltc_pair.target
    expect(trade_page_url).to eq "https://extstock.com/markets/ETH_LTC"
  end

  it 'fetch pairs and assign the correct base/target' do
    pairs = client.pairs('extstock')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'extstock'
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_ltc_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'LTC'
    expect(ticker.market).to eq 'extstock'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order_book' do
    order_book = client.order_book(eth_ltc_pair)

    expect(order_book.base).to eq eth_ltc_pair.base
    expect(order_book.target).to eq eth_ltc_pair.target
    expect(order_book.market).to eq eth_ltc_pair.market
    expect(order_book.asks).to be_a Array
    expect(order_book.bids).to be_a Array
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trades' do
    trades = client.trades(eth_ltc_pair)
    first_trade_result = trades.first

    expect(first_trade_result.trade_id).to_not be nil
    expect(first_trade_result.base).to eq eth_ltc_pair.base
    expect(first_trade_result.target).to eq eth_ltc_pair.target
    expect(first_trade_result.market).to eq eth_ltc_pair.market
    # response['side'] is always returning nil currently seems like a bug from ExtStock
    # expect(first_trade_result.type).to_not be nil
    expect(first_trade_result.price).to_not be nil
  end
end
