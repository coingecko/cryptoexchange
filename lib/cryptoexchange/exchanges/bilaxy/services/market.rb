module Cryptoexchange::Exchanges
  module Bilaxy
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
          "#{Cryptoexchange::Exchanges::Bilaxy::Market::API_URL}/ticker/24hr"
        end

        def adapt_all(output)
          output.map do |ticker|
            base, target = ticker[0].split("_")
            market_pair = Cryptoexchange::Models::MarketPair.new({
              base: base,
              target: target,
              market: Bilaxy::Market::NAME
            })
            adapt(market_pair, ticker)
          end
        end

        def adapt(market_pair, ticker)
          data = ticker[1]
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bilaxy::Market::NAME
          ticker.last      = NumericHelper.to_d(data['close'])
          ticker.volume    = NumericHelper.to_d(data['base_volume'])
          ticker.timestamp = nil
          ticker.payload   = data
          ticker
        end
      end
    end
  end
end
