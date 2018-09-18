module Cryptoexchange::Exchanges
  module Axnet
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Axnet::Market::API_URL}/returnTicker"
        
        def fetch
          output = super
          adapt(output)
        end

        def adapt(pair_list)
          market_pairs = []
          pair_list.each do |pair, value|
            base, target = pair.split("_")
            market_pairs << Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Axnet::Market::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end
