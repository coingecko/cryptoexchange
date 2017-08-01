module Cryptoexchange::Exchanges
  module Livecoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Livecoin::Market::API_URL}/exchange/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |ticker|
            base, target = ticker['symbol'].split('/')
            market_pair = Cryptoexchange::Models::MarketPair.new
            market_pair.base = base
            market_pair.target = target
            market_pair.market = Livecoin::Market::NAME
            market_pairs << market_pair
          end
          market_pairs
        end
      end
    end
  end
end
