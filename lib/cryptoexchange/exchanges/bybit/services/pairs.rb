module Cryptoexchange::Exchanges
  module Bybit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bybit::Market::API_URL}/symbols"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['result'].map do |pair|
            base, target = pair["base_currency"], pair["quote_currency"]
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bybit::Market::NAME
            )
          end
        end
      end
    end
  end
end
