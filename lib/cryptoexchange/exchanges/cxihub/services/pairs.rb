module Cryptoexchange::Exchanges
  module Cxihub
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Cxihub::Market::API_URL}/market/v1/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output['data']
          pairs.map do |pair|
            target, base = pair['market'].split('/')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Cxihub::Market::NAME
            )
          end
        end
      end
    end
  end
end
