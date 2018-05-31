module Cryptoexchange::Exchanges
  module Okex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Okex::Market::API_URL}/tickers.do"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['tickers'].map do |pair|
            base, target = pair['symbol'].split("_")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Okex::Market::NAME
            )
          end
        end
      end
    end
  end
end
