module Cryptoexchange::Exchanges
  module Qtrade
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Qtrade::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output['data']['markets']
          market_pairs = []
          pairs.each do |pair|
            base = pair['market_currency']
            target = pair['base_currency'] # This is correct, but confusing
            market_pair = Cryptoexchange::Models::MarketPair.new
            market_pair.base = base
            market_pair.target = target
            market_pair.market = Qtrade::Market::NAME
            market_pairs << market_pair
          end
        end
      end
    end
  end
end
