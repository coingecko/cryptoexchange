module Cryptoexchange::Exchanges
  module Cobinhood
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Cobinhood::Market::API_URL}/market/trading_pairs"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output['result']["trading_pairs"]
          pairs.map do |pair|
            Cryptoexchange::Models::MarketPair.new \
              base: pair['base_currency_id'],
              target: pair['quote_currency_id'],
              market: Cobinhood::Market::NAME
          end
        end
      end
    end
  end
end
