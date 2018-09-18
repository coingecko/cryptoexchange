module Cryptoexchange::Exchanges
  module Raisex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Raisex::Market::API_URL}/v1"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
             if pair['symbol']
              base, target = pair['symbol'].split('/')
              market_pairs << Cryptoexchange::Models::MarketPair.new(
                                base: base,
                                target: target,
                                market: Raisex::Market::NAME
                              )
            end
          end
          market_pairs
        end
      end
    end
  end
end
