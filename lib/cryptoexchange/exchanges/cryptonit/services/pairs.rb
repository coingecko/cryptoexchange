module Cryptoexchange::Exchanges
  module Cryptonit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Cryptonit::Market::API_URL}/trading-pairs-info"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.collect do |pair|
            base, target = pair['name'].split("/")

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Cryptonit::Market::NAME
            )
          end
        end
      end
    end
  end
end
