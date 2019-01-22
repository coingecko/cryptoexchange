module Cryptoexchange::Exchanges
  module Coinlim
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinlim::Market::API_URL}/server/tickers"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base:   pair['tradeCurrency'],
              target: pair['currency'],
              market: Coinlim::Market::NAME
            )
          end
        end
      end
    end
  end
end
