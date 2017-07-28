module Cryptoexchange::Exchanges
  module Bleutrade
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bleutrade::Market::API_URL}/public/getmarkets"


        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output['result'].each do |pair|
            market_pairs << Bleutrade::Models::MarketPair.new(
                              base: pair['BaseCurrency'],
                              target: pair['MarketCurrency'],
                              market: Bleutrade::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
