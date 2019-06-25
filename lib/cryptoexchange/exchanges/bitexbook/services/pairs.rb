module Cryptoexchange::Exchanges
  module Bitexbook
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitexbook::Market::API_URL}/symbols"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair['alias'].split('/')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bitexbook::Market::NAME
            )
          end
        end
      end
    end
  end
end
