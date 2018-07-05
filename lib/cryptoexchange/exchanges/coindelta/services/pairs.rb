module Cryptoexchange::Exchanges
  module Coindelta
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coindelta::Market::API_URL}/public/getticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair['MarketName'].split('-')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Coindelta::Market::NAME
            )
          end
        end
      end
    end
  end
end
