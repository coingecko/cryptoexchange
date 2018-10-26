module Cryptoexchange::Exchanges
  module Vbitex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Vbitex::Market::API_URL}/Home/markets/tickers.html"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair['symbol'].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Vbitex::Market::NAME
            )
          end
        end
      end
    end
  end
end
