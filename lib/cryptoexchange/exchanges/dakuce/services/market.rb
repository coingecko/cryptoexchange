module Cryptoexchange::Exchanges
  module Dakuce
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
          "#{Cryptoexchange::Exchanges::Dakuce::Market::API_URL}/getmarketsummaries"
        end

        def adapt_all(output)
          output['result'].map do |pair|
            base, target = pair['name'].split('/')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Dakuce::Market::NAME
              )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Dakuce::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['volume']/output['last'].to_f)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
