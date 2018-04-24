module Cryptoexchange::Exchanges
  module Dsx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Dsx::Market::API_URL}/info"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['pairs'].collect do |_key, pair|
            Cryptoexchange::Models::MarketPair.new(
              base:   pair['base_currency'],
              target: pair['quoted_currency'],
              market: Dsx::Market::NAME
            )
          end
        end
      end
    end
  end
end
