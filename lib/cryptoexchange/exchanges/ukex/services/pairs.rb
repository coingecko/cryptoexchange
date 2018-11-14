module Cryptoexchange::Exchanges
  module Ukex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Ukex::Market::API_URL}/pairs"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair.split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base.upcase,
                              target: target.upcase,
                              market: Ukex::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
