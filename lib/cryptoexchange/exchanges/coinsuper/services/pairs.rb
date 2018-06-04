module Cryptoexchange::Exchanges
  module Coinsuper
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinsuper::Market::API_URL}/market/hour24Market"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output['data'].each do |pair|
            if pair[1]['isFrozen']==0
              base, target = pair[0].split('/')
              market_pairs << Cryptoexchange::Models::MarketPair.new(
                                base: base,
                                target: target,
                                market: Coinsuper::Market::NAME
                              )
            end
          end
          market_pairs
        end
      end
    end
  end
end
