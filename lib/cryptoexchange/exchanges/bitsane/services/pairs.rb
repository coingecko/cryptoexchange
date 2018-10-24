module Cryptoexchange::Exchanges
  module Bitsane
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitsane::Market::API_URL}/ticker"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair[0].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Bitsane::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
