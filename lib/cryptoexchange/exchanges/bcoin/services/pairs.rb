module Cryptoexchange::Exchanges
  module Bcoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = Bcoin::Market::API_URL

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair, data|
            base, target = pair.split('/')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bcoin::Market::NAME
            )
          end
        end
      end
    end
  end
end
