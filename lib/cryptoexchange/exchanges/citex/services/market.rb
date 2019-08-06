module Cryptoexchange::Exchanges
  module Citex
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
          "#{Cryptoexchange::Exchanges::Citex::Market::API_URL}/allticker"
        end

        def adapt_all(output)
          output = output["data"]["ticker"]
          output.map do |pair|
            base, target = pair["symbol"].split("_")
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Citex::Market::NAME
            )
            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Citex::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output["vol"])
          ticker.bid    = NumericHelper.to_d(output["buy"])
          ticker.ask    = NumericHelper.to_d(output["sell"])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
