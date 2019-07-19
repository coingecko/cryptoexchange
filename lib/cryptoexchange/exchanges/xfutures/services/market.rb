module Cryptoexchange::Exchanges
  module Xfutures
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
          "#{Cryptoexchange::Exchanges::Xfutures::Market::API_URL}/spot/v3/instruments/ticker"
        end

        def adapt_all(output)
          output.map do |pair|
            base, target = pair["instrument_id"].split('-')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Xfutures::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Xfutures::Market::NAME
          ticker.last      = NumericHelper.to_d(output["last"])
          ticker.high      = NumericHelper.to_d(output["high_24h"])
          ticker.low       = NumericHelper.to_d(output["low_24h"])
          ticker.volume    = NumericHelper.to_d(output["base_volume_24h"])
          ticker.ask       = NumericHelper.to_d(output["ask"])
          ticker.bid       = NumericHelper.to_d(output["bid"])          
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
