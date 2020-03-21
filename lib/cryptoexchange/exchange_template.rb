module Cryptoexchange
  class ExchangeTemplate
    def initialize(identifier)
      @identifier = identifier
      @class_name = convert_identifier_to_class_name(identifier)
    end

    def market
      <<~'EOF' % {class_name: @class_name, identifier: @identifier}
        module Cryptoexchange::Exchanges
          module %{class_name}
            class Market < Cryptoexchange::Models::Market
              NAME = '%{identifier}'
              API_URL = ''

              def self.trade_page_url(args={})
                "https://exchange.com/#{args[:base]}-#{args[:target]}"
              end
            end
          end
        end 
      EOF
    end

    def pairs
      <<~'EOF' % {class_name: @class_name}
        module Cryptoexchange::Exchanges
          module %{class_name}
            module Services
              class Pairs < Cryptoexchange::Services::Pairs
                PAIRS_URL = "#{Cryptoexchange::Exchanges::%{class_name}::Market::API_URL}/tickers"

                def fetch
                  output = super
                  adapt(output)
                end

                def adapt(output)
                  output.map do |output|
                    base, target = output["symbol"].split('_')
                    Cryptoexchange::Models::MarketPair.new(
                      base: base,
                      target: target,
                      market: %{class_name}::Market::NAME
                    )
                  end
                end
              end
            end
          end
        end
      EOF
    end

    def tickers
      <<~'EOF' % {class_name: @class_name}
        module Cryptoexchange::Exchanges
          module %{class_name}
            module Services
              class Market < Cryptoexchange::Services::Market
                class << self
                  def supports_individual_ticker_query?
                    false
                  end
                end

                def fetch
                  output = super ticker_url
                  adapt_all(output)
                end

                def ticker_url
                  "#{Cryptoexchange::Exchanges::%{class_name}::Market::API_URL}/tickers"
                end

                def adapt_all(output)
                  output.map do |output|
                    base, target = output["symbol"].split('_')
                    market_pair = Cryptoexchange::Models::MarketPair.new(
                                    base: base,
                                    target: target,
                                    market: %{class_name}::Market::NAME
                                  )

                    adapt(output, market_pair)
                  end
                end

                def adapt(output, market_pair)
                  ticker           = Cryptoexchange::Models::Ticker.new
                  ticker.base      = market_pair.base
                  ticker.target    = market_pair.target
                  ticker.market    = %{class_name}::Market::NAME
                  ticker.bid       = NumericHelper.to_d(output['highestBid'])
                  ticker.ask       = NumericHelper.to_d(output['lowestAsk'])
                  ticker.last      = NumericHelper.to_d(output['last'])
                  ticker.volume    = NumericHelper.to_d(output['quoteVolume'])
                  ticker.high      = NumericHelper.to_d(output['high24hr'])
                  ticker.low       = NumericHelper.to_d(output['low24hr'])
                  ticker.change    = NumericHelper.to_d(output['percentChange'])
                  ticker.timestamp = nil
                  ticker.payload   = output
                  ticker
                end
              end
            end
          end
        end
      EOF
    end

    def order_book
      <<~'EOF' % {class_name: @class_name}
        module Cryptoexchange::Exchanges
          module %{class_name}
            module Services
              class OrderBook < Cryptoexchange::Services::Market
                class << self
                  def supports_individual_ticker_query?
                    true
                  end
                end

                def fetch(market_pair)
                  output = super(ticker_url(market_pair))
                  adapt(output, market_pair)
                end

                def ticker_url(market_pair)
                  base   = market_pair.base
                  target = market_pair.target
                  "#{Cryptoexchange::Exchanges::%{class_name}::Market::API_URL}/data?Pair=#{base}_#{target}"
                end

                def adapt(output, market_pair)
                  order_book = Cryptoexchange::Models::OrderBook.new

                  order_book.base      = market_pair.base
                  order_book.target    = market_pair.target
                  order_book.market    = %{class_name}::Market::NAME
                  order_book.asks      = adapt_orders output['Asks']
                  order_book.bids      = adapt_orders output['Bids']
                  order_book.timestamp = Time.now.to_i
                  order_book.payload   = output
                  order_book
                end

                def adapt_orders(orders)
                  orders.collect do |order_entry|
                    Cryptoexchange::Models::Order.new(price:  order_entry['Price'],
                                                      amount: order_entry['Amount']
                    )
                  end
                end
              end
            end
          end
        end
      EOF
    end

    def trades
      <<~'EOF' % {class_name: @class_name}
        module Cryptoexchange::Exchanges
          module %{class_name}
            module Services
              class Trades < Cryptoexchange::Services::Market
                def fetch(market_pair)
                  output = super(ticker_url(market_pair))
                  adapt(output, market_pair)
                end

                def ticker_url(market_pair)
                  base   = market_pair.base
                  target = market_pair.target
                  "#{Cryptoexchange::Exchanges::%{class_name}::Market::API_URL}/data?Pair=#{base}_#{target}"
                end

                def adapt(output, market_pair)
                  output['History'].collect do |trade|
                    tr = Cryptoexchange::Models::Trade.new
                    tr.trade_id  = nil
                    tr.base      = market_pair.base
                    tr.target    = market_pair.target
                    tr.market    = %{class_name}::Market::NAME
                    tr.type      = trade['Type'].downcase
                    tr.price     = trade['Price']
                    tr.amount    = trade['Amount']
                    tr.timestamp = trade['UnixTime'].to_i
                    tr.payload   = trade
                    tr
                  end
                end
              end
            end
          end
        end
      EOF
    end

    def market_spec
      <<~'EOF' % {class_name: @class_name, identifier: @identifier}
        require 'spec_helper'

        RSpec.describe Cryptoexchange::Exchanges::%{class_name}::Market do
          it { expect(described_class::NAME).to eq '%{identifier}' }
          it { expect(described_class::API_URL).to eq '' }
        end
      EOF
    end

    def integration_spec
      <<~'EOF' % {class_name: @class_name, identifier: @identifier}
        require 'spec_helper'

        RSpec.describe '%{class_name} integration specs' do
          let(:client) { Cryptoexchange::Client.new }
          let(:market) { '%{identifier}' }
          let(:btc_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USDT', market: market) }

          it 'fetch pairs' do
            pairs = client.pairs(market)
            expect(pairs).not_to be_empty

            pair = pairs.first
            expect(pair.base).to_not be nil
            expect(pair.target).to_not be nil
            expect(pair.market).to eq market
          end

          it 'give trade url' do
            trade_page_url = client.trade_page_url market, base: btc_usdt_pair.base, target: btc_usdt_pair.target
            expect(trade_page_url).to eq ""
          end

          it 'fetch ticker' do
            ticker = client.ticker(btc_usdt_pair)

            expect(ticker.base).to eq 'BTC'
            expect(ticker.target).to eq 'USDT'
            expect(ticker.market).to eq market
            expect(ticker.last).to be_a Numeric
            expect(ticker.ask).to be_a Numeric
            expect(ticker.bid).to be_a Numeric
            expect(ticker.low).to be_a Numeric
            expect(ticker.high).to be_a Numeric
            expect(ticker.volume).to be_a Numeric
            expect(ticker.change).to be_a Numeric
            expect(ticker.timestamp).to be nil
            
            expect(ticker.payload).to_not be nil
          end

          it 'fetch order book' do
            order_book = client.order_book(btc_usdt_pair)

            expect(order_book.base).to eq 'BTC'
            expect(order_book.target).to eq 'USDT'
            expect(order_book.market).to eq market
            expect(order_book.asks).to_not be_empty
            expect(order_book.bids).to_not be_empty
            expect(order_book.asks.first.price).to_not be_nil
            expect(order_book.bids.first.amount).to_not be_nil
            expect(order_book.bids.first.timestamp).to be_nil
            expect(order_book.asks.count).to be > 0
            expect(order_book.bids.count).to be > 0
            expect(order_book.timestamp).to be_nil
            expect(order_book.payload).to_not be nil
          end

          it 'fetch trade' do
            trades = client.trades(btc_usdt_pair)
            trade = trades.sample

            expect(trades).to_not be_empty
            expect(trade.base).to eq 'BTC'
            expect(trade.target).to eq 'USDT'
            expect(trade.market).to eq market
            expect(trade.trade_id).to_not be_nil
            expect(['buy', 'sell']).to include trade.type
            expect(trade.price).to_not be_nil
            expect(trade.amount).to_not be_nil
            expect(trade.timestamp).to be_a Numeric
            expect(trade.payload).to_not be nil
          end
        end
      EOF
    end            

    private

    def convert_identifier_to_class_name(identifier)
      identifier.split('_').collect(&:capitalize).join
    end    
  end
end
