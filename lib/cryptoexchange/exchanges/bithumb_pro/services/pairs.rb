module Cryptoexchange::Exchanges
  module BithumbGlobal
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::BithumbGlobal::Market::API_URL}/spot/ticker?symbol=ALL"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            base, target = pair["s"].split("-")
            Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: BithumbGlobal::Market::NAME
              )
          end.compact
        end
      end
    end
  end
end
