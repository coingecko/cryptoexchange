module Cryptoexchange::Exchanges
  module Alluma
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Alluma::Market::API_URL}/server/misc/all_ticker"

        def fetch
          output = super
          output['data'].map do |pair|
            next if pair['hidePair'] == true

            Cryptoexchange::Models::MarketPair.new(
              base:   pair['target'],
              target: pair['base'],
              market: Alluma::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
