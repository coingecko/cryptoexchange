require 'spec_helper'

RSpec.describe 'btse_futures integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'btse_futures', contract_interval: "quarterly", inst_id: "BTCZ19") }

  it 'fetch pairs' do
    pairs = client.pairs('btse_futures')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.contract_interval).to_not be nil
    expect(pair.inst_id).to_not be nil
    expect(pair.market).to eq 'btse_futures'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'btse_futures', inst_id: btc_usd_pair.inst_id
    expect(trade_page_url).to eq "https://www.btse.com/en/futures/BTCZ19"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.inst_id).to eq 'BTCZ19'
    expect(ticker.market).to eq 'btse_futures'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_usd_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'USD'
    expect(order_book.market).to eq 'btse_futures'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 0
    expect(order_book.bids.count).to be > 0
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(btc_usd_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.trade_id).to_not be_nil
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'USD'
    expect(['BUY', 'SELL']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'btse_futures'
  end

  context 'fetch contract stat' do
    it 'fetch contract stat' do
      contract_stat = client.contract_stat(btc_usd_pair)

      expect(contract_stat.base).to eq 'BTC'
      expect(contract_stat.target).to eq 'USD'
      expect(contract_stat.market).to eq 'btse_futures'
      expect(contract_stat.index).to be nil
      expect(contract_stat.open_interest).to be_a Numeric
      expect(contract_stat.timestamp).to be nil
      expect(contract_stat.index_identifier).to eq 'BtseFutures~BTC'
      expect(contract_stat.index_name).to eq 'BTSE BTC'

      expect(contract_stat.payload).to_not be nil
    end

    it 'fetch perpetual contract details' do
      contract_stat = client.contract_stat(btc_usd_pair)

      expect(contract_stat.expire_timestamp).to be_a Numeric
      expect(contract_stat.start_timestamp).to be_a Numeric
      expect(contract_stat.contract_type).to eq 'futures'
    end
  end
end
