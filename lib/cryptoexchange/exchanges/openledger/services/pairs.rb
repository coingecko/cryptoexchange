module Cryptoexchange::Exchanges
  module Openledger
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Openledger::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['result'].map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base:   pair['MarketCurrency'],
              target: pair['BaseCurrency'],
              market: Openledger::Market::NAME
            )
          end
        end
      end
    end
  end
end
