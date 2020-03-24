module Cryptoexchange::Exchanges
  module Drgx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "https://feeds-api.drgx.io/drgx/tickers.json"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair, ticker|
            market_pair = Cryptoexchange::Models::MarketPair.new
            base, target = pair.split('_')
            market_pair.base = base
            market_pair.target = target
            market_pair.market = Drgx::Market::NAME
            market_pairs << market_pair
          end
          market_pairs
        end
      end
    end
  end
end
