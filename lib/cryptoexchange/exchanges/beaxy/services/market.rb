module Cryptoexchange::Exchanges
  module Beaxy
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
          "#{Cryptoexchange::Exchanges::Beaxy::Market::API_URL}/Symbols"
        end

        def adapt_all(output)
          output.map do |ticker|
            base, target = ticker["n"].split("-")
            market_pair = Cryptoexchange::Models::MarketPair.new({
              base: base,
              target: target,
              market: Beaxy::Market::NAME
            })
            adapt(market_pair, ticker)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Beaxy::Market::NAME
          ticker.last      = NumericHelper.to_d(output['lp'])
          ticker.high       = NumericHelper.to_d(output["l24h"])
          ticker.low       = NumericHelper.to_d(output["l24l"])
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(output['v']), ticker.last)

          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
