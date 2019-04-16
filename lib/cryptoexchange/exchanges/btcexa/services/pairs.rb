module Cryptoexchange::Exchanges
  module Btcexa
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Btcexa::Market::API_URL}/market/ticker"

        def fetch
          output = super
          output['result'].map do |output|
            base, target = output[0].split("_")
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Btcexa::Market::NAME
            )
          end
        end
      end
    end
  end
end
