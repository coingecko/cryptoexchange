module Cryptoexchange::Exchanges
  module Floatsv
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          response = super(ticker_url)
          adapt_all(response)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Floatsv::Market::API_URL}/spot/v3/instruments/ticker"
        end

        def adapt_all(response)
          response.map do |ticker|
            base, target = ticker["instrument_id"].split("-")
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Floatsv::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Floatsv::Market::NAME
          ticker.low       = NumericHelper.to_d(output["low_24h"])
          ticker.high      = NumericHelper.to_d(output["high_24h"])
          ticker.last      = NumericHelper.to_d(output["last"])
          ticker.bid       = NumericHelper.to_d(output["bid"])
          ticker.ask       = NumericHelper.to_d(output["ask"])
          ticker.volume    = NumericHelper.to_d(output["quote_volume_24h"])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
