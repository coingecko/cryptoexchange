module Cryptoexchange::Exchanges
  module Mandala
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Mandala::Market::API_URL}/market/get-market-summary"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          data = output['data'].map
          data.each do |k, v|
            target, base = k.split("_")
            Cryptoexchange::Models::MarketPair.new(
                base:   base,
                target: target,
                market: Mandala::Market::NAME
            )
          end
        end
      end
    end
  end
end
