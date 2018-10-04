module Cryptoexchange::Exchanges
  module Alluma
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Alluma::Market::API_URL}/server/user/appConfig"

        def fetch
          output = super
          output['customCoinPairList'].map do |pair|
            next if pair['hidePair'] == true
            Cryptoexchange::Models::MarketPair.new(
              base: pair['Product1Symbol'],
              target: pair['Product2Symbol'],
              market: Alluma::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
