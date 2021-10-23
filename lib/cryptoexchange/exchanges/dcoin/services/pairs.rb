module Cryptoexchange::Exchanges
  module Dcoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Dcoin::Market::API_URL}/api/v1/allticker"

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
              market: Dcoin::Market::NAME
            )
          end
        end
      end
    end
  end
end
