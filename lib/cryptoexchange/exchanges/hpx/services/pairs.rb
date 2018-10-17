module Cryptoexchange::Exchanges
  module Hpx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Hpx::Market::API_URL}/tickers"

        def fetch
          output = super
          market_pairs = []
          output['data'].each do |pair|
            base, target = pair['symbol'].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base.upcase,
                              target: target.upcase,
                              market: Hpx::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
