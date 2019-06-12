module Cryptoexchange::Exchanges
  module Mercuriex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Mercuriex::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output['tickers'].each do |pair|
            market_pair = Cryptoexchange::Models::MarketPair.new
            base, target = pair[0].split("-")
            market_pair.base = base
            market_pair.target = target
            market_pair.market = Mercuriex::Market::NAME
            market_pairs << market_pair
          end
          market_pairs
        end
      end
    end
  end
end
