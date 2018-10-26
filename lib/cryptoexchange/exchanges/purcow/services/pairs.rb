module Cryptoexchange::Exchanges
  module Purcow
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Purcow::Market::API_URL}/tickers"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['ticker'].map do |pair|
            base, target = pair['symbol'].split('_')
              Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: Purcow::Market::NAME
            )
          end
        end
      end
    end
  end
end
