module Cryptoexchange::Exchanges
  module Ninecoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Ninecoin::Market::API_URL}/cy_mark_list"

        def fetch
          output = super
          market_pairs = []
          output['data'].each do |pair|
            base, target = pair['cy_mark'].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Ninecoin::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
