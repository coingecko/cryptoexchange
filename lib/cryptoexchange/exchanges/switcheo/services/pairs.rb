module Cryptoexchange::Exchanges
  module Switcheo
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Switcheo::Market::API_URL}/v2/pairs"


        def fetch
          adapt(super)
        end

        def adapt(output)
          output.collect do |pair|
            base, target = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Switcheo::Market::NAME
            )
          end
        end
      end
    end
  end
end
