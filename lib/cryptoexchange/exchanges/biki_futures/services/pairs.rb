module Cryptoexchange::Exchanges
  module BikiFutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::BikiFutures::Market::API_URL}/instruments"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["data"]["instruments"].map do |output|
            Cryptoexchange::Models::MarketPair.new(
              base: output["base_coin"],
              target: output["quote_coin"],
              inst_id: output["instrument_id"],
              contract_interval: "perpetual",
              market: BikiFutures::Market::NAME
            )
          end
        end
      end
    end
  end
end
