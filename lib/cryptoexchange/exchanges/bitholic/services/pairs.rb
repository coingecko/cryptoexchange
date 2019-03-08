module Cryptoexchange::Exchanges
  module Bitholic
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitholic::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["market"].map do |key, _value|
            target, base = key.split("_")

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bitholic::Market::NAME
            )
          end
        end
      end
    end
  end
end
