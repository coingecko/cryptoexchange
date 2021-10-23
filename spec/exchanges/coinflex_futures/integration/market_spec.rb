require 'spec_helper'

RSpec.describe 'Coinflex Futures integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:ethmar_usdtmar_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'USDT', inst_id: 'ETHMAR/USDTMAR', market: 'coinflex_futures') }

  it 'fetch pairs' do
    pairs = client.pairs('coinflex_futures')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.inst_id).to_not be nil
    expect(pair.contract_interval).to_not be nil
    expect(pair.market).to eq 'coinflex_futures'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'coinflex_futures', base: ethmar_usdtmar_pair.base, target: ethmar_usdtmar_pair.target, inst_id: ethmar_usdtmar_pair.inst_id
    expect(trade_page_url).to eq "https://trading.coinflex.com/ui/trade/ethmar_usdtmar"
  end

  it 'fetch ticker' do
    ticker = client.ticker(ethmar_usdtmar_pair)

    expect(ticker.base).to eq ethmar_usdtmar_pair.base
    expect(ticker.target).to eq ethmar_usdtmar_pair.target
    expect(ticker.market).to eq ethmar_usdtmar_pair.market
    expect(ticker.inst_id).to eq 'ETHMAR/USDTMAR'
    expect(ticker.contract_interval).to_not be nil
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    pending("Cannot query orderbook using human friendly ID")
    
    order_book = client.order_book(ethmar_usdtmar_pair)

    expect(order_book.base).to eq ethmar_usdtmar_pair.base
    expect(order_book.target).to eq ethmar_usdtmar_pair.target
    expect(order_book.market).to eq ethmar_usdtmar_pair.market
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end

  context 'fetch contract stat' do
    it 'fetch futures contract details' do
      contract_stat = client.contract_stat(ethmar_usdtmar_pair)
      expect(contract_stat.base).to eq 'ETH'
      expect(contract_stat.target).to eq 'USDT'
      expect(contract_stat.market).to eq 'coinflex_futures'
      expect(contract_stat.contract_type).to eq 'futures'
      expect(contract_stat.index_identifier).to be nil
      expect(contract_stat.index_name).to be nil
    end
  end
end
