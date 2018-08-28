module Cryptoexchange::Exchanges
  module Yunex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs

        PAIRS_URL = "#{Cryptoexchange::Exchanges::Yunex::Market::API_URL}/api/base/coins/tree"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
            market_pairs = []
            output["data"].each do |market|
              market["plist"].each do |pair|
                market_pair = Cryptoexchange::Models::MarketPair.new
                base, target = pair['symbol'].split('_')

                market_pair.base = base
                market_pair.target = target
                market_pair.market = Yunex::Market::NAME
                market_pairs << market_pair
              end
            end
            market_pairs
        end
      end
    end
  end
end
