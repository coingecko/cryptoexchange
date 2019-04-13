module Cryptoexchange::Exchanges
  module Whitebit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Whitebit::Market::API_URL}/tickers"

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
                              market: Whitebit::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
