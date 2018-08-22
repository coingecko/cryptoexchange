module Cryptoexchange::Exchanges
  module Btcturk
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Btcturk::Market::API_URL}/ticker"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            symbol = pair['pair']
            base, target = symbol.split(/(TRY$)+(.*)|(USDT$)+(.*)/)
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Btcturk::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
