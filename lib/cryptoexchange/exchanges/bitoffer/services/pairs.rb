module Cryptoexchange::Exchanges
  module Bitoffer
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitoffer::Market::API_URL}/cash/instrument"

        def fetch
          output = super
          adapt(output["data"])
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair["symbol"].split("-")
            inst_id = pair["instrumentId"]
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bitoffer::Market::NAME,
              inst_id: inst_id,
            )
          end
        end
      end
    end
  end
end
