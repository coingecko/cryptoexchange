module Cryptoexchange::Exchanges
  module Financex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs

        PAIRS_URL = "#{Cryptoexchange::Exchanges::Financex::Market::API_URL}"

        def fetch
          response = super
          adapt(response)
        end

        def adapt(response)
          market_pairs = []
          response.keys.each do |pair|
            target, base = pair.split("_")
            market_pairs << Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Financex::Market::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end
