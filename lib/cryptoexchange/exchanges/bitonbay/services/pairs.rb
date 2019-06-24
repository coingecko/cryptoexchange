module Cryptoexchange::Exchanges
  module Bitonbay
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitonbay::Market::API_URL}/api-public-ticker"

        def fetch
          output = super
          output['lastprice'].map do |base, target|
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target.keys.first,
              market: Bitonbay::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
