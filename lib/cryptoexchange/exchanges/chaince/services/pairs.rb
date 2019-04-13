module Cryptoexchange::Exchanges
  module Chaince
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Chaince::Market::API_URL}/market/pairs"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair[1]['full_code'].split('/')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Chaince::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
