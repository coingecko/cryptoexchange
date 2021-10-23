module Cryptoexchange::Exchanges
  module Satoexchange
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Satoexchange::Market::API_URL}/get_markets/"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['markets'].map do | pair |
            base, target = pair['slug'].split('/')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              inst_id: pair['id'],
              market: Satoexchange::Market::NAME
            )
          end
        end
      end
    end
  end
end
