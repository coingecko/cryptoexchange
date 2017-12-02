module Cryptoexchange::Exchanges
  module Coinone
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinone::Market::API_URL}/ticker?currency=all"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |_, value|
            next unless value.is_a? Hash
            market_pair = Cryptoexchange::Models::MarketPair.new
            market_pair.base = value['currency']
            market_pair.target = 'krw'
            market_pair.market = Coinone::Market::NAME
            market_pairs << market_pair
          end
          market_pairs
        end
      end
    end
  end
end
