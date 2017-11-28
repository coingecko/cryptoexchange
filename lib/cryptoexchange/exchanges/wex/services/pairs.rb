module Cryptoexchange::Exchanges
  module Wex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Tidex::Market::API_URL}/info"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output['pairs'].each_key do |pair|
            base, target = pair.split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Wex::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
