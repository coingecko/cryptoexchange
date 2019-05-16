module Cryptoexchange::Exchanges
  module BithumbPro
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::BithumbPro::Market::API_URL}/spot/ticker?symbol=ALL"

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
                market: BithumbPro::Market::NAME
              )
          end.compact
        end
      end
    end
  end
end
