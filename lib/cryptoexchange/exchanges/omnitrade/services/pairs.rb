module Cryptoexchange::Exchanges
  module Omnitrade
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Omnitrade::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            pair = split(pair['name'])
            Cryptoexchange::Models::MarketPair.new(
              base: pair[:base],
              target: pair[:target],
              market: Omnitrade::Market::NAME
            )
          end
        end

        private

        def split(pair)
          {
            base: pair.split('/').first,
            target: pair.split('/').last
          }
        end
      end
    end
  end
end
