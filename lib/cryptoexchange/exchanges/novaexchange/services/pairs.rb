module Cryptoexchange::Exchanges
  module Novaexchange
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Novaexchange::Market::API_URL}/markets/"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output['markets'].each do |ticker|
            market_pair = Novaexchange::Models::MarketPair.new
            market_pair.base = ticker['basecurrency']
            market_pair.target = ticker['currency']
            market_pair.market = Novaexchange::Market::NAME
            market_pairs << market_pair
          end
          market_pairs
        end
      end
    end
  end
end
