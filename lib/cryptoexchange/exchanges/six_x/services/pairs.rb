module Cryptoexchange::Exchanges
  module SixX
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::SixX::Market::API_URL}/api/v1/tickers"

        def fetch
          output = super
          adapt(output['ticker'])
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair['symbol'].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: SixX::Market::NAME
            )
          end
        end
      end
    end
  end
end
