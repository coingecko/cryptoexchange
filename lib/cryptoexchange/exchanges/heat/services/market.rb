module Cryptoexchange::Exchanges
  module Heat
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
          "#{Cryptoexchange::Exchanges::Heat::Market::TICKER_URL}"
        end

        def adapt_all(output)
          output.map do |ticker|
                market_pair = Cryptoexchange::Models::MarketPair.new(
                                base: ticker["assetProperties"] ? JSON.parse(ticker["assetProperties"].split(",")[0].delete("[")) : "HEAT",
                                target: ticker["currencyProperties"] ? JSON.parse(ticker["currencyProperties"].split(",")[0].delete("[")) : "HEAT",
                                market: Heat::Market::NAME
                              )
                adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Heat::Market::NAME
          ticker.high      = NumericHelper.to_d(output["hr24High"])
          ticker.low       = NumericHelper.to_d(output["hr24Low"])
          ticker.last      = NumericHelper.to_d(output["lastPrice"])
          ticker.volume    = NumericHelper.to_d(output["hr24AssetVolume"])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
