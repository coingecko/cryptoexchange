require 'spec_helper'
require 'pry'

RSpec.describe 'Exmarkets integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:sample_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'BTC', market: 'exmarkets') }


  describe '.trade_page_url' do
    let(:trade_page_url) { client.trade_page_url 'exmarkets', base: sample_pair.base, target: sample_pair.target }

    it 'givee correct trade page url' do
      expect(trade_page_url).to eq "https://exmarkets.com/trade/eth-btc"
    end
  end

  describe '#pairs' do
    let(:pairs) { client.pairs('exmarkets') }

    it 'fetches pairs' do
      expect(pairs).not_to be_empty
    end

    it 'fills pair details correctly', :agregate_failures do
      pair = pairs.first
      expect(pair.base).to eq 'ETH'
      expect(pair.target).to eq 'BTC'
      expect(pair.market).to eq 'exmarkets'
    end
  end

  describe '#ticker' do
    let(:ticker) { client.ticker(sample_pair) }
    let(:expected_attributes) do
      {
        ask: NumericHelper.to_d(0.036976), base: 'ETH', bid: NumericHelper.to_d(0.036973),
        high: NumericHelper.to_d(0.037926), last: NumericHelper.to_d(0.036975),
        low: NumericHelper.to_d(0.036606),
        market: 'exmarkets', target: 'BTC', volume:  NumericHelper.to_d(637.805), payload: {
          'last'=>'0.03697500', 'high'=>'0.03792600', 'low'=>'0.03660600', 'volume'=>'637.80500000',
          'bid'=>'0.03697300', 'ask'=>'0.03697600'
        }
      }
    end

    it 'assigns correct attributes' do
      actual_attributes = expected_attributes.each_key.with_object({}) do |variable_name, data|
        data[variable_name] = ticker.send(variable_name)
      end

      expect(actual_attributes).to eq expected_attributes
    end
  end

  describe '#order-book' do
    let(:order_book) { client.order_book(sample_pair) }

    it 'has correct pair fields assigned', :agregate_failures do
      expect(order_book.base).to eq 'ETH'
      expect(order_book.target).to eq 'BTC'
      expect(order_book.market).to eq 'exmarkets'
    end

    it 'has a list of asks' do
      expect(order_book.asks).to_not be_empty
    end

    it 'has a list of bids' do
      expect(order_book.bids).to_not be_empty
    end

    it 'has no timestamp' do
      expect(order_book.timestamp).to be_nil
    end
  end

  describe '#trades' do
    let(:trades) { client.trades(sample_pair) }
    let(:trade) { trades.sort_by(&:trade_id).first }

    it 'has correct pair fields assigned', :agregate_failures do
      expect(trade.base).to eq 'ETH'
      expect(trade.target).to eq 'BTC'
      expect(trade.market).to eq 'exmarkets'
    end

    it 'has correct price' do
      expect(trade.price).to eq NumericHelper.to_d(0.036956)
    end

    it 'has correct type' do
      expect(trade.type).to eq 'BUY'
    end

    it 'has trade_id assigned' do
      expect(trade.trade_id).to eq 6882264
    end
  end
end
