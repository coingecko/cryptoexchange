module Cryptoexchange::Exchanges
  module Palitanx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Palitanx::Market::API_URL}/getmarkets"

        def fetch
          output = super
          market_pairs = []
          output['result'].each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['BaseCurrency'],
                              target: pair['MarketCurrency'],
                              market: Palitanx::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
