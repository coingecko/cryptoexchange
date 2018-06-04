module Cryptoexchange::Exchanges
  module Stellarport
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Stellarport::Market::API_URL}"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output["byPercentGain"].each do |pair|
            base = pair["soldAssetCode"]
            market_pairs << Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: "XLM",
              market: Stellarport::Market::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end