module Cryptoexchange::Exchanges
  module BoostxExchange
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::BoostxExchange::Market::API_URL}=returnTicker"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair[1]['coinPair'].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: BoostxExchange::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
