module Cryptoexchange::Exchanges
  module Buyucoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Buyucoin::Market::API_URL}/liveData"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |value|
            target, base  = value["marketName"].split('-')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Buyucoin::Market::NAME
            )
          end
        end
      end
    end
  end
end
