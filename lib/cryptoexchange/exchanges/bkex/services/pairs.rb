module Cryptoexchange::Exchanges
  module Bkex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bkex::Market::API_URL}/commons/market/tickers"

        def fetch
          output = super
          adapt(output['data'])
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair['pair'].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bkex::Market::NAME
            )
          end
        end
      end
    end
  end
end
