module Cryptoexchange::Exchanges
  module Cex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Cex::Market::API_URL}/currency_limits"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output['data']['pairs']
          pairs.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base: pair['symbol2'],
              target: pair['symbol1'],
              market: Cex::Market::NAME
            )
          end
        end
      end
    end
  end
end
