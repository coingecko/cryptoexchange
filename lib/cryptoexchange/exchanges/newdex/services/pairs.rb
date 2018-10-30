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
            base, target = pair["symbol"].split("_")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Newdex::Market::NAME
            )
          end
        end
      end
    end
  end
end
