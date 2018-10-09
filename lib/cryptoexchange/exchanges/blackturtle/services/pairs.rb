module Cryptoexchange::Exchanges
  module Blackturtle
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Blackturtle::Market::API_URL}/tickers"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair['symbol'].split('/')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Blackturtle::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
