module Cryptoexchange::Exchanges
  module Birake
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Birake::Market::API_URL}/public/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            Cryptoexchange::Models::MarketPair.new({
              base: pair['quote'],
              target: pair['base'],
              market: Birake::Market::NAME
            })
          end.compact
        end

      end
    end
  end
end
