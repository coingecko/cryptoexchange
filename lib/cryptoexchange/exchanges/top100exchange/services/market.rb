module Cryptoexchange::Exchanges
  module Top100exchange
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
          "#{Cryptoexchange::Exchanges::Top100exchange::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output.map do |pair|
            base, target = pair['pair'].split('-')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Top100exchange::Market::NAME
            )
            adapt(market_pair, pair['data'])
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Top100exchange::Market::NAME
          ticker.last      = NumericHelper.to_d(output['LastPrice'])
          ticker.high      = NumericHelper.to_d(output['HighestPrice'])
          ticker.low       = NumericHelper.to_d(output['LowestPrice'])
          ticker.volume    = NumericHelper.to_d(output['TradedVolume'])
          ticker.change    = NumericHelper.to_d(output['PercentChanged'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
