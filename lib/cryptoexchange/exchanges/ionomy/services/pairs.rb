module Cryptoexchange::Exchanges
  module Ionomy
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Ionomy::Market::API_URL}/public/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |output|
            target, base = output['market'].split('-')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Ionomy::Market::NAME
            )
          end
        end
      end
    end
  end
end
