module Cryptoexchange::Exchanges
  module Nibyx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Nibyx::Market::API_URL}/"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair['id'].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Nibyx::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
