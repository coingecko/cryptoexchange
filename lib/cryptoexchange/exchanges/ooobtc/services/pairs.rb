module Cryptoexchange::Exchanges
  module Ooobtc
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Ooobtc::Market::API_URL}/getallticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            base, target = pair['tickername'].split("_")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Ooobtc::Market::NAME
            )
          end
        end
      end
    end
  end
end
