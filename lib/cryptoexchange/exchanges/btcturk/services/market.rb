module Cryptoexchange::Exchanges
  module Btcturk
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
          "#{Cryptoexchange::Exchanges::Btcturk::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            symbol = pair['pairNormalized']
            base, target = symbol.split('_')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Btcturk::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Btcturk::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'].to_f)
          ticker.high      = NumericHelper.to_d(output['high'].to_f)
          ticker.low       = NumericHelper.to_d(output['low'].to_f)
          ticker.bid       = NumericHelper.to_d(output['bid'].to_f)
          ticker.ask       = NumericHelper.to_d(output['ask'].to_f)
          ticker.volume    = NumericHelper.to_d(output['volume'].to_f)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
