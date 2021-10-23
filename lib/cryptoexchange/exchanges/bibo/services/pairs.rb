module Cryptoexchange::Exchanges
  module Bibo
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bibo::Market::API_URL}/api/v1/allticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['ticker'].map do |ticker|
            base, target = ticker["symbol"].split("_")
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bibo::Market::NAME
            )
          end
        end
      end
    end
  end
end
