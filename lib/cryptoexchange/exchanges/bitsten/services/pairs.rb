module Cryptoexchange::Exchanges
  module Bitsten
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitsten::Market::API_URL}/public/getticker/all"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output['result']
          pairs.map do |pair, _ticker|
            base, target = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bitsten::Market::NAME
            )
          end
        end
      end
    end
  end
end
