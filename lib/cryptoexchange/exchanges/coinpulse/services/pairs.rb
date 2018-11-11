module Cryptoexchange::Exchanges
  module Coinpulse
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinpulse::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          result = if output.key?('result') then output['result'] else [] end
          result.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              target: pair['BaseCurrency'],
              base: pair['MarketCurrency'],
              market: Coinpulse::Market::NAME
            )
          end
        end
      end
    end
  end
end
