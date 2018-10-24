module Cryptoexchange::Exchanges
  module P2pb2b
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::P2pb2b::Market::API_URL}/tickers"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            symbol = pair[0].upcase
            base, target = symbol.split(/(BTC$)+(.*)|(ETH$)+(.*)|(USD$)+(.*)/)
            next unless base && target
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: P2pb2b::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
