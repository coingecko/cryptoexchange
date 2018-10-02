module Cryptoexchange::Exchanges
  module Dragonex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Dragonex::Market::API_URL}/api/v1/symbol/all/"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            base, target = pair['symbol'].split('_')
            Cryptoexchange::Models::Dragonex::MarketPair.new(
              base: base,
              target: target,
              id: pair['symbol_id'],
              market: Dragonex::Market::NAME
            )
          end
        end
      end
    end
  end
end
