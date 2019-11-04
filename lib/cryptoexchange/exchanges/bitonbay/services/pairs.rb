module Cryptoexchange::Exchanges
  module Bitonbay
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitonbay::Market::API_URL}/ticker"

        def fetch
          output = super
          output['data'].map do |output|
            base = output["coin_type"]
            target = output["market_type"]
            
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bitonbay::Market::NAME
            )
          end
        end
      end
    end
  end
end
