module Cryptoexchange::Exchanges
  module StocksExchange
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::StocksExchange::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base: pair['currency'],
              target: pair['partner'],
              market: StocksExchange::Market::NAME
            )
          end
        end
      end
    end
  end
end
