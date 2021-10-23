module Cryptoexchange::Exchanges
  module Newdex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Newdex::Market::API_URL}/v1/common/symbols"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            inst_id, base, target = pair['symbol'].split('-')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              inst_id: inst_id,
              market: Newdex::Market::NAME
            )
          end
        end
      end
    end
  end
end
