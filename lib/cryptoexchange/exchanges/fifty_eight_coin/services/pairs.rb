module Cryptoexchange::Exchanges
  module FiftyEightCoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        
        PAIRS_URL = "#{Cryptoexchange::Exchanges::FiftyEightCoin::Market::API_URL}/product/list"

        def fetch
          response = super
          adapt(response)
        end

        def adapt(response)
          market_pairs = []
          response['data']['productList'].each do |pair|
            target, base = pair['quoteCurrencyName'], pair['baseCurrencyName']
            market_pairs << Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: FiftyEightCoin::Market::NAME
            )
          end
          market_pairs
        end

      end
    end
  end
end