require 'spec_helper'

RSpec.describe 'kraken_futures integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'kraken_futures' }
  let(:eth_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'USD', inst_id: "PI_ETHUSD", market: 'kraken_futures', contract_interval: "perpetual") }

  it 'fetch pairs' do
    pairs = client.pairs('kraken_futures')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.inst_id).to eq 'pi_ethusd'
    expect(pair.market).to eq 'kraken_futures'
    expect(pair.contract_interval).to eq "perpetual"
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, inst_id: eth_usd_pair.inst_id
    expect(trade_page_url).to eq "https://futures.kraken.com/dashboard?symbol=PI_ETHUSD"
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_usd_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'kraken_futures'
    expect(ticker.inst_id).to eq 'pi_ethusd'
    expect(ticker.contract_interval).to eq "perpetual"
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
    expect(ticker.contract_interval).to eq "perpetual"
  end

  it 'fetch order book' do
    order_book = client.order_book(eth_usd_pair)

    expect(order_book.base).to eq 'ETH'
    expect(order_book.target).to eq 'USD'
    expect(order_book.market).to eq 'kraken_futures'

    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 10
    expect(order_book.bids.count).to be > 10
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trades' do
    trades = client.trades(eth_usd_pair)
    trade = trades.first

    expect(trade.base).to eq 'ETH'
    expect(trade.target).to eq 'USD'
    expect(trade.market).to eq 'kraken_futures'

    expect(trade.amount).to_not be_nil
    expect(trade.price).to_not be_nil
    expect(2000..Date.today.year).to include(Time.at(trade.timestamp).year)
    expect(trade.trade_id).to be_a Numeric
    expect(trade.type).to eq("buy").or eq("sell")
  end

  it 'fetch contract stat' do
    contract_stat = client.contract_stat(eth_usd_pair)

    expect(contract_stat.base).to eq 'ETH'
    expect(contract_stat.target).to eq 'USD'
    expect(contract_stat.market).to eq 'kraken_futures'
    expect(contract_stat.index).to be_a Numeric
    expect(contract_stat.open_interest).to be_a Numeric
    expect(contract_stat.timestamp).to be nil

    expect(contract_stat.payload).to_not be nil
  end
end
