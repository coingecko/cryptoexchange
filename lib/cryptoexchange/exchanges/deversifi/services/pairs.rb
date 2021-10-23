module Cryptoexchange::Exchanges
  module Deversifi
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Deversifi::Market::API_URL}/v1/trading/r/last24HoursVolume"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["symbols"].map do |pair, ticker|
            base, target = pair.split(":")
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Deversifi::Market::NAME
            )
          end
        end
      end
    end
  end
end