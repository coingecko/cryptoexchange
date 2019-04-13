module Cryptoexchange::Exchanges
  module Coinbe
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinbe::Market::API_URL}/graphs/ticker/ticker.json"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            target, base = pair[0].split('_')
              Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: Coinbe::Market::NAME
            )
          end
        end
      end
    end
  end
end
