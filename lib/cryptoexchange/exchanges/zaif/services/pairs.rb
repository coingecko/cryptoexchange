module Cryptoexchange::Exchanges
  module Zaif
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Zaif::Market::API_URL}/currency_pairs/all"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pair = Cryptoexchange::Models::MarketPair.new
            base, target = pair['currency_pair'].split('_')
            market_pair.base = base
            market_pair.target = target
            market_pair.market = Zaif::Market::NAME
            market_pairs << market_pair
          end
          market_pairs
        end
      end
    end
  end
end
