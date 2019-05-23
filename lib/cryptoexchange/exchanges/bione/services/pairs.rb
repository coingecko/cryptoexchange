module Cryptoexchange::Exchanges
  module Bione
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bione::Market::API_URL}/tickers"

        def fetch
          output = super
          output['data'].map do |pair|
            base, target = pair['symbol'].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base.upcase,
              target: target.upcase,
              market: Bione::Market::NAME
            )
          end
        end
      end
    end
  end
end
