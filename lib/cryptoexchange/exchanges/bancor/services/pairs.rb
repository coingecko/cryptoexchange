module Cryptoexchange::Exchanges
  module Bancor
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bancor::Market::API_URL}/currencies/convertiblePairs"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |base, target|
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bancor::Market::NAME
            )
          end
        end
      end
    end
  end
end
