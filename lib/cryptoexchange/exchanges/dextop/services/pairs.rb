module Cryptoexchange::Exchanges
  module Dextop
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Dextop::Market::API_URL}/pairlist/ETH"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['pairs'].map do |pair|
            target, base = pair['pairId'].split("_")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Dextop::Market::NAME
            )
          end
        end
      end
    end
  end
end
