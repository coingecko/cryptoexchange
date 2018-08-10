module Cryptoexchange::Exchanges
  module Rfinex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Rfinex::Market::API_URL}/markets"

        def fetch
          output = super
          market_pairs = []
          output['body'].each do |pair|
            base, target = pair['name'].split('/')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Rfinex::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
