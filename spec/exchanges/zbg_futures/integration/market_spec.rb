require 'spec_helper'

RSpec.describe 'ZBG Futures integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eth_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'USDT', inst_id: "ETH_USDT", contract_interval: "perpetual", market: 'zbg_futures') }

  it 'fetch pairs' do
    pairs = client.pairs('zbg_futures')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.inst_id).to_not be nil
    expect(pair.contract_interval).to_not be nil
    expect(pair.market).to eq 'zbg_futures'
  end

  it 'give trade url' do
    pair = Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'USDT', market: 'zbg_futures')
    trade_page_url = client.trade_page_url pair.market, base: pair.base, target: pair.target
    expect(trade_page_url).to eq "https://futures.zbg.com/ETH_USDT"
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_usdt_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.inst_id).to eq 'ETH_USDT'
    expect(ticker.contract_interval).to eq 'perpetual'
    expect(ticker.market).to eq 'zbg_futures'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(eth_usdt_pair)

    expect(order_book.base).to eq 'ETH'
    expect(order_book.target).to eq 'USDT'
    expect(order_book.market).to eq 'zbg_futures'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 10
    expect(order_book.bids.count).to be > 10
    expect(order_book.timestamp).to be nil
    expect(order_book.payload).to_not be nil
  end

  context 'fetch contract stat' do
    it 'fetch contract details' do
      contract_stat = client.contract_stat(eth_usdt_pair)

      expect(contract_stat.base).to eq 'ETH'
      expect(contract_stat.target).to eq 'USDT'
      expect(contract_stat.market).to eq 'zbg_futures'
      expect(contract_stat.index_identifier).to be nil
      expect(contract_stat.index_name).to be nil
      expect(contract_stat.contract_type).to eq 'perpetual'
      expect(contract_stat.timestamp).to be nil
    end
  end
end
