module Cryptoexchange::Exchanges
  module SafeTrade
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::SafeTrade::Market::API_URL}/v2/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair["name"].split("/")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: SafeTrade::Market::NAME,
              inst_id: pair["id"],
            )
          end
        end
      end
    end
  end
end
