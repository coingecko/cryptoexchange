module Cryptoexchange::Exchanges
  module PrimeXbt
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
          "#{Cryptoexchange::Exchanges::PrimeXbt::Market::API_URL}/markets?category=crypto"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            base, target = pair['base'], pair['quote']
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              inst_id: pair['name'],
              market: PrimeXbt::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = PrimeXbt::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.volume    = NumericHelper.to_d(output['turnover'])
          ticker.change    = NumericHelper.to_d(output['change24h'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
