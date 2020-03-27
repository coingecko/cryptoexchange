module Cryptoexchange::Exchanges
  module Okex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Okex::Market::API_URL}/instruments/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair['product_id'].split("-")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Okex::Market::NAME
            )
          end
        end
      end
    end
  end
end
