module Cryptoexchange::Exchanges
  module Tidex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Tidex::Market::API_URL}/info"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['pairs'].keys.map do |pair|
            base, target = pair.split("_")
            Cryptoexchange::Models::MarketPair.new({
              base: base,
              target: target,
              market: Tidex::Market::NAME
            })
          end
        end
      end
    end
  end
end
