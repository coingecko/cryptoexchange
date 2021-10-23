module Cryptoexchange::Exchanges
  module Remitano
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Remitano::Market::API_URL}/volumes/market_summaries"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |key, ticker|
            base = ticker['currency1']
            target = ticker['currency2']

            market_pair = Cryptoexchange::Models::MarketPair.new
            market_pair.base = base
            market_pair.target = target
            market_pair.market = Remitano::Market::NAME
            market_pairs << market_pair
          end
          market_pairs
        end
      end
    end
  end
end
