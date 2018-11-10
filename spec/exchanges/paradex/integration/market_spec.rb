require 'spec_helper'

RSpec.describe 'Paradex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:hav_weth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'HAV', target: 'WETH', market: 'paradex') }
  let(:weth_dai_pair) { Cryptoexchange::Models::MarketPair.new(base: 'WETH', target: 'DAI', market: 'paradex') }
  let(:filename) { Cryptoexchange::Credentials.send(:filename) }

  before do
    allow(Cryptoexchange::Credentials).to receive(:get).with('paradex').and_return({ 'api_key' => 'blah'})
  end

  it 'fetch pairs' do
    pairs = client.pairs('paradex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'paradex'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'paradex', base: weth_dai_pair.base, target: weth_dai_pair.target
    expect(trade_page_url).to eq "https://paradex.io/market/weth-dai"
  end

  it 'fetch ticker' do
    ticker = client.ticker(hav_weth_pair)

    expect(ticker.base).to eq 'HAV'
    expect(ticker.target).to eq 'WETH'
    expect(ticker.market).to eq 'paradex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    allow(Cryptoexchange::Exchanges::Paradex::Market).to receive(:fetch_api_key).and_return "PadexApiKeyPlaceholder"
    order_book = client.order_book(weth_dai_pair)

    expect(order_book.base).to eq 'WETH'
    expect(order_book.target).to eq 'DAI'
    expect(order_book.market).to eq 'paradex'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    allow(Cryptoexchange::Exchanges::Paradex::Market).to receive(:fetch_api_key).and_return "PadexApiKeyPlaceholder"
    trades = client.trades(weth_dai_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.trade_id).to_not be_nil
    expect(trade.base).to eq 'WETH'
    expect(trade.target).to eq 'DAI'
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'paradex'
  end
end
