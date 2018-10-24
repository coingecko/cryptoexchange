module Cryptoexchange::Exchanges
  module Bitrue
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitrue::Market::API_URL}/kline-api/public.json?command=returnTicker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair, ticker|
            next if ticker['isFrozen'] == '1'
            base, target = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bitrue::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
