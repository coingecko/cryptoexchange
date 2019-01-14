module Cryptoexchange::Exchanges
  module Tokenmom
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Tokenmom::Market::API_URL}/market/get_markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['markets'].map do |market|
            market['tokens'].map do |pair|
              base, target = pair['market_id'].split('-')
              Cryptoexchange::Models::MarketPair.new(
                base:   base,
                target: target,
                market: Tokenmom::Market::NAME
              )
            end
          end
        end
      end
    end
  end
end
