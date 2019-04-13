module Cryptoexchange::Exchanges
  module Bw
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bw::Market::API_URL}/website/marketcontroller/getproduct"

        def fetch
          output = super
          market_pairs = []
          output['data'].each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['baseAsset'],
                              target: pair['quoteAsset'],
                              market: Bw::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
