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
          output.map do |_key, pair|
            next if pair.class != Hash
            Cryptoexchange::Models::MarketPair.new(
              base: pair['currency'],
              target: pair['partner'],
              market: Cryptoexchange::Exchanges::StocksExchange::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
