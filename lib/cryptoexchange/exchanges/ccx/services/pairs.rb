module Cryptoexchange::Exchanges
  module Ccx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Ccx::Market::API_URL}/markets.json"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base: pair['base_unit'],
              target: pair['quote_unit'],
              market: Ccx::Market::NAME
            )
          end
        end
      end
    end
  end
end
