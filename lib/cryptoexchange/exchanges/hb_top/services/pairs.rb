module Cryptoexchange::Exchanges
  module HbTop
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::HbTop::Market::API_URL}/tickers"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            base, target = pair['symbol'].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: HbTop::Market::NAME
            )
          end
        end
      end
    end
  end
end
