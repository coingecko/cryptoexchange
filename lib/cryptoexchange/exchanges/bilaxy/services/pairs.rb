module Cryptoexchange::Exchanges
  module Bilaxy
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bilaxy::Market::API_URL}/ticker/24hr"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            pair = pair[0]
            base, target = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bilaxy::Market::NAME
            )
          end
        end
      end
    end
  end
end
