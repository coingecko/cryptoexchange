module Cryptoexchange::Exchanges
  module Gdax
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Gdax::Market::API_URL}/products"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |product|
            base = product['base_currency']
            target = product['quote_currency']

            market_pair = Cryptoexchange::Models::MarketPair.new
            market_pair.base = base
            market_pair.target = target
            market_pair.market = Gdax::Market::NAME
            market_pairs << market_pair
          end
          market_pairs
        end
      end
    end
  end
end
