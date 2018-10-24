module Cryptoexchange::Exchanges
  module Chainrift
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Chainrift::Market::API_URL}/Public/Market?"

        def fetch
          output = super
          adapt(output['data'])
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair['symbol'].split("/")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Chainrift::Market::NAME
            )
          end
        end
      end
    end
  end
end
