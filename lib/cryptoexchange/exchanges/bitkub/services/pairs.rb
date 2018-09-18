module Cryptoexchange::Exchanges
  module Bitkub
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitkub::Market::API_URL}/market/symbols"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['result'].collect do |pair|
            target, base = pair['symbol'].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bitkub::Market::NAME
            )
          end
        end
      end
    end
  end
end
