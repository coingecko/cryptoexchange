module Cryptoexchange::Exchanges
  module Novadax
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
       PAIRS_URL = "#{Cryptoexchange::Exchanges::Novadax::Market::API_URL}/market/tickers"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            base, target = pair["symbol"].split("_")
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Novadax::Market::NAME
            )
          end
        end
      end
    end
  end
end
