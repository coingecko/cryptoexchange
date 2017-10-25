module Cryptoexchange::Exchanges
  module Bleutrade
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bleutrade::Market::API_URL}/public/getmarkets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output['result'].each do |pair|
            base, target = pair['MarketName'].split("_")
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Bleutrade::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
