module Cryptoexchange::Exchanges
  module Vcc
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Vcc::Market::API_URL}/summary"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output['data'].each do |pair|
            base, target = pair[0].split('_')
            market_pairs <<
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Vcc::Market::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end
