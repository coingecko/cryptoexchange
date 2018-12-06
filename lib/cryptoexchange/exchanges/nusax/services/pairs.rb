module Cryptoexchange::Exchanges
  module Nusax
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Nusax::Market::API_URL}/markets"

        def fetch
          output = super
          output.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base: pair["name"].split("/")[0],
              target: pair["name"].split("/")[1],
              market: Nusax::Market::NAME,
              inst_id: pair["id"]
            )
          end
        end
      end
    end
  end
end
