module Cryptoexchange::Exchanges
  module StellarTerm
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
          "#{Cryptoexchange::Exchanges::StellarTerm::Market::API_URL}/ticker.json"
        end

        def adapt_all(output)
          output["assets"].map do |asset|
            next if asset["id"] == "XLM-native" || asset["price_XLM"].nil? || asset["volume24h_XLM"].nil?

            base = asset["id"]
            target = "XLM"
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: StellarTerm::Market::NAME
            )
            adapt(asset, market_pair)
          end.compact
        end

        def adapt(asset, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = StellarTerm::Market::NAME
          ticker.last      = NumericHelper.to_d(asset["price_XLM"])
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(asset["volume24h_XLM"]), ticker.last)
          ticker.timestamp = nil
          ticker.payload   = asset
          ticker
        end
      end
    end
  end
end
