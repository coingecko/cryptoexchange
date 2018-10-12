module Cryptoexchange::Exchanges
  module Tokok
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Tokok::Market::API_URL}/tickers"

        def fetch
          output = super
          market_pairs = []
          output['ticker'].each do |pair|
            base, target = pair['symbol'].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Tokok::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
