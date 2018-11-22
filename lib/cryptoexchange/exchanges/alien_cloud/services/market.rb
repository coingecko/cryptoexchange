module Cryptoexchange::Exchanges
  module AlienCloud
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
          "#{Cryptoexchange::Exchanges::AlienCloud::Market::API_URL}/trade/pairs"
        end

        def adapt_all(output)
          output.map do |pair|
            base, target = pair['pairName'].split('_')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: AlienCloud::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = AlienCloud::Market::NAME
          ticker.last      = NumericHelper.to_d(output['closeValue'])
          ticker.high      = NumericHelper.to_d(output['maxValue'])
          ticker.low       = NumericHelper.to_d(output['minValue'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
