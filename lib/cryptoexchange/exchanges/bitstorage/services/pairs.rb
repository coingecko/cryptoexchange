module Cryptoexchange::Exchanges
  module Bitstorage
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitstorage::Market::API_URL}/ticker"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair['pairs'].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Bitstorage::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
