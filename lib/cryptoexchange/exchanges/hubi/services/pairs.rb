module Cryptoexchange::Exchanges
  module Hubi
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Hubi::Market::API_URL}/allticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['ticker'].map do |pair|
            base, target = pair['symbol'].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Hubi::Market::NAME
            )
          end
        end
      end
    end
  end
end
