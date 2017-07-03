module Cryptopia
  module Services
    class Pairs < CryptoexchangeRuby::Services::Pairs
      PAIRS_URL = "#{Cryptopia::Market::API_URL}/GetTradePairs"

      def fetch
        output = super(PAIRS_URL)
        adapt(output)
      end

      def adapt(output)
        pairs = output['Data']
        market_pairs = []
        pairs.each do |pair|
          base, target = pair['Label'].split('/')
          market_pair = Cryptopia::Models::MarketPair.new
          market_pair.base = base
          market_pair.target = target
          market_pairs << market_pair
        end
        market_pairs
      end
    end
  end
end
