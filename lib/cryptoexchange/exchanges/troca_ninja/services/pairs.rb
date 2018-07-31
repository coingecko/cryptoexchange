module Cryptoexchange::Exchanges
  module TrocaNinja
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::TrocaNinja::Market::API_URL}/volume"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            target, base = pair['parName'].split("_")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: TrocaNinja::Market::NAME
            )
          end
        end
      end
    end
  end
end
