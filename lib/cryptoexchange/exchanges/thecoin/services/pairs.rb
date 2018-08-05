module Cryptoexchange::Exchanges
  module Thecoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Thecoin::Market::API_URL}/public/getmarkets"
        
        def fetch
          output = super
          market_pairs = []
          output['result'].each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['BaseCurrency'],
                              target: pair['MarketCurrency'],
                              market: Thecoin::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
