module Cryptoexchange::Exchanges
  module Instantbitex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Instantbitex::Market::API_URL}/availablepairs"

        def fetch
          output = super
          market_pairs = []
          output['combinations'].each do |pair|
            base, target = pair.split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Instantbitex::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
