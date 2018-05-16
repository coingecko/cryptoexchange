module Cryptoexchange::Exchanges
  module Bithash
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bithash::Market::API_URL}/info"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['pairs'].map do |pair, _value|
            base, target = pair.split("_")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bithash::Market::NAME
            )
          end
        end
      end
    end
  end
end
