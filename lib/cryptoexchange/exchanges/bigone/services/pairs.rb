module Cryptoexchange::Exchanges
  module Bigone
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bigone::Market::API_URL}"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair[1][0]["base"],
                              target: pair[1][0]["quote"],
                              market: Bigone::Market::NAME
                            )
          end
          market_pairs
        end

      end
    end
  end
end
