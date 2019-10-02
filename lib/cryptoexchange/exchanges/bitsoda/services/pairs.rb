module Cryptoexchange::Exchanges
  module Bitsoda
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitsoda::Market::API_URL}/market/prices"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["data"].map do |pair, ticker|
            base, target = pair.split("_")
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bitsoda::Market::NAME
            )
          end
        end
      end
    end
  end
end
