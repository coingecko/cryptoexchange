require "spec_helper"

RSpec.describe "StocksExchange integration specs" do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { "stocks_exchange" }
  let(:eth_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: "ETH", target: "BTC", market: "stocks_exchange", inst_id: 2) }

  it "fetch pairs" do
    pairs = client.pairs market
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq market
    expect(pair.inst_id).to_not be nil
  end

  it "fetch ticker" do
    ticker = client.ticker(eth_btc_pair)

    expect(ticker.base).to eq "ETH"
    expect(ticker.target).to eq "BTC"
    expect(ticker.market).to eq "stocks_exchange"
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(eth_btc_pair)

    expect(order_book.base).to eq eth_btc_pair.base
    expect(order_book.target).to eq eth_btc_pair.target
    expect(order_book.market).to eq market
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 0
    expect(order_book.bids.count).to be > 0
    expect(order_book.payload).to_not be nil
  end

  it "give trade url" do
    trade_page_url = client.trade_page_url "stocks_exchange", base: eth_btc_pair.base, target: eth_btc_pair.target
    expect(trade_page_url).to eq "https://app.stex.com/en/basic-trade/pair/BTC/ETH/240"
  end
end
