module Cryptoexchange::Exchanges
  module Ecxx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Ecxx::Market::API_URL}/allTicker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["ticker"].map do |pair|
            base, target = pair["symbol"].split("_")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Ecxx::Market::NAME
            )
          end
        end
      end
    end
  end
end
