require 'pry'

module Cryptoexchange::Exchanges
  module Altmarkets
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "https://altmarkets.io/api/v2/tickers"
        end

        def adapt_all(output)
          client = Cryptoexchange::Client.new
          pairs = client.pairs('altmarkets')

          output.map do |ticker|
            pair = pairs.find {|i| i.inst_id == ticker[0]}
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   pair.base,
              target: pair.target,
              market: Altmarkets::Market::NAME
            )
            adapt(market_pair, ticker)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Altmarkets::Market::NAME
          ticker.last      = NumericHelper.to_d(output[1]['ticker']['last'])
          ticker.high      = NumericHelper.to_d(output[1]['ticker']['high'])
          ticker.low       = NumericHelper.to_d(output[1]['ticker']['low'])
          ticker.bid       = NumericHelper.to_d(output[1]['ticker']['buy'])
          ticker.ask       = NumericHelper.to_d(output[1]['ticker']['sell'])
          ticker.volume    = NumericHelper.to_d(output[1]['ticker']['vol'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
