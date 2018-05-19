module Cryptoexchange::Exchanges
  module Coinnox
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinnox::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair['name'].split('/')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Coinnox::Market::NAME
            )
          end
        end
      end
    end
  end
end
