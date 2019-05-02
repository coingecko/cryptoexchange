module Cryptoexchange::Exchanges
  module Omgfin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Omgfin::Market::API_URL}"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            base, target = pair["symbol"].split('_')
            market_pairs <<
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Omgfin::Market::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end
