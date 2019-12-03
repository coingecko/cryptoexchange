module Cryptoexchange::Exchanges
  module Bvnex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bvnex::Market::API_URL}/ticker/list"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            base, target = pair[0].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bvnex::Market::NAME
            )
          end
        end
      end
    end
  end
end
