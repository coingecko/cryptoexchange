module Cryptoexchange::Exchanges
  module Mercatox
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Mercatox::Market::API_URL}/json24"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output['pairs'].each do |pair, ticker|
            market_pair = Cryptoexchange::Models::MarketPair.new
            base, target = pair.split('_')
            market_pair.base = base
            market_pair.target = target
            market_pair.market = Mercatox::Market::NAME
            market_pairs << market_pair
          end
          market_pairs
        end
      end
    end
  end
end
