module Cryptoexchange::Exchanges
  module Yobit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Yobit::Market::API_URL}/info"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output['pairs'].each do |pair, info|
            market_pair = Cryptoexchange::Models::MarketPair.new
            base, target = pair.split('_')
            market_pair.base = base
            market_pair.target = target
            market_pair.market = Yobit::Market::NAME
            market_pairs << market_pair
          end
          market_pairs
        end
      end
    end
  end
end
