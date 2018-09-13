module Cryptoexchange::Exchanges
  module Coindirect
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coindirect::Market::API_URL}/exchange/market"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair['symbol'].split('-')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Coindirect::Market::NAME
            )
          end
        end
      end
    end
  end
end
