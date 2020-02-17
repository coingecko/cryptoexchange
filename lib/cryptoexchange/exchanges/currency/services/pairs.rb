module Cryptoexchange::Exchanges
  module Currency
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Currency::Market::API_URL}/api/v1/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair, _ticker|
            base, target = pair.split('/')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Currency::Market::NAME
            )
          end
        end
      end
    end
  end
end
