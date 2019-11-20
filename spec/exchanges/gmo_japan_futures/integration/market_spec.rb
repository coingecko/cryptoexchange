require 'spec_helper'

RSpec.describe 'GmoJapanFutures integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_jpy_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'JPY', inst_id: 'BTC_JPY', contract_interval: "perpetual", market: 'gmo_japan_futures') }

  it 'fetch pairs' do
    pairs = client.pairs('gmo_japan_futures')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.contract_interval).to eq 'perpetual'
    expect(pair.inst_id).to eq 'BTC_JPY'
    expect(pair.market).to eq 'gmo_japan_futures'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'gmo_japan_futures', base: btc_jpy_pair.base, target: btc_jpy_pair.target, inst_id: btc_jpy_pair.inst_id
    expect(trade_page_url).to eq "https://coin.z.com/jp/corp/information/btc-market/"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_jpy_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'JPY'
    expect(ticker.contract_interval).to eq 'perpetual'
    expect(ticker.market).to eq 'gmo_japan_futures'
    expect(ticker.inst_id).to eq 'BTC_JPY'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_jpy_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'JPY'
    expect(order_book.market).to eq 'gmo_japan_futures'

    expect(order_book.asks).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.asks.first.amount).to_not be_nil
    expect(order_book.asks.first.timestamp).to be_nil

    expect(order_book.bids).to_not be_empty
    expect(order_book.bids.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil

    expect(order_book.timestamp).to be nil
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(btc_jpy_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'JPY'
    expect(trade.market).to eq 'gmo_japan_futures'
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end

  context 'fetch contract stat' do
    it 'fetch perpetual contract details' do
      contract_stat = client.contract_stat(btc_jpy_pair)
      expect(contract_stat.base).to eq 'BTC'
      expect(contract_stat.target).to eq 'JPY'
      expect(contract_stat.market).to eq 'gmo_japan_futures'
      expect(contract_stat.contract_type).to eq 'perpetual'
      expect(contract_stat.index_identifier).to be nil
      expect(contract_stat.index_name).to be nil
    end
  end
end
