module Cryptoexchange::Exchanges
  module Bitholic
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

        def adapt_all(output)
          output['market'].map do |pair, payload|
            target, base = pair.split('_')

            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bitholic::Market::NAME
            )
            adapt(payload, market_pair)
          end
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Bitholic::Market::API_URL}/ticker"
        end

        def adapt(payload, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitholic::Market::NAME
          ticker.ask       = NumericHelper.to_d(payload['ask'])
          ticker.bid       = NumericHelper.to_d(payload['bid'])
          ticker.last      = NumericHelper.to_d(payload['last'])
          ticker.volume    = NumericHelper.to_d(payload['volume24h'])
          ticker.timestamp = nil
          ticker.payload   = payload
          ticker
        end
      end
    end
  end
end
