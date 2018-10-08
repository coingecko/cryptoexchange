module Cryptoexchange::Exchanges
  module Ovis
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Ovis::Market::API_URL}/tickers"

        def fetch
          output = super
          market_pairs = []
          output['data'].each do |pair|
            base, target = pair['name'].split('/')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Ovis::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
