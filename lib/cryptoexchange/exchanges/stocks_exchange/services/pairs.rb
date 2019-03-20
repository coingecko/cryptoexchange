module Cryptoexchange::Exchanges
  module StocksExchange
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::StocksExchange::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["data"].map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base: pair['currency_code'],
              target: pair['market_code'],
              market: Cryptoexchange::Exchanges::StocksExchange::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
