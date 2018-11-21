module Cryptoexchange::Exchanges
  module Bitnaru
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitnaru::Market::API_URL}/public"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair[0].split('/')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Bitnaru::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
