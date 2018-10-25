module Cryptoexchange::Exchanges
  module Tradeio
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Tradeio::Market::API_URL}/marketdata-ws/24hr"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair['instrument'].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base.upcase,
                              target: target.upcase,
                              market: Tradeio::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
