module Cryptoexchange::Exchanges
  module Kineticex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL    = "#{Cryptoexchange::Exchanges::Kineticex::Market::API_URL}/symbol"
        AUTO_INFLATE = true

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            next if pair['IsTradeAllowed'] == false
            Cryptoexchange::Models::MarketPair.new(
              base:   pair['MarginCurrency'],
              target: pair['ProfitCurrency'],
              market: Kineticex::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
