module Cryptoexchange::Exchanges
  module Fyrus
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Fyrus::Market::API_URL}/symbols"

        def fetch
          output = super
          market_pairs = []
          output['data'].each do |pair|
            base, target = pair[0].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base.upcase,
                              target: target.upcase,
                              market: Fyrus::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
