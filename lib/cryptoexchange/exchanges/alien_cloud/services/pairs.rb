module Cryptoexchange::Exchanges
  module AlienCloud
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::AlienCloud::Market::API_URL}/trade/pairs"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair['pairName'].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base.upcase,
                              target: target.upcase,
                              market: AlienCloud::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
