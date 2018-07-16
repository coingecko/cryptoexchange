module Cryptoexchange::Exchanges
  module Altex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Altex::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair, ticker|
            base, target = pair.split("_")
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Altex::Market::NAME
            )
          end
        end
      end
    end
  end
end
