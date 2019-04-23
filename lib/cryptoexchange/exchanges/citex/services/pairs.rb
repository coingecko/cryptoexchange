module Cryptoexchange::Exchanges
  module Citex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Citex::Market::API_URL}"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output
          market_pairs = []
          pairs.each do |pair|
            base, target = pair["baseAssetName"], pair["quoteAssetName"]
            market_pairs <<
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Citex::Market::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end
