module Cryptoexchange::Exchanges
  module Coinall
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinall::Market::API_URL}/spot/v3/products/ticker"
        
        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair['product_id'].split('-')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Coinall::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
