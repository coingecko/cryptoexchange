module Cryptoexchange::Exchanges
  module Bittrex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bittrex::Market::API_URL}/public/getmarkets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output['result']
          market_pairs = []
          pairs.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['MarketCurrency'],
                              target: pair['BaseCurrency'],
                              market: Bittrex::Market::NAME
                            )
          end

          market_pairs
        end
      end
    end
  end
end
