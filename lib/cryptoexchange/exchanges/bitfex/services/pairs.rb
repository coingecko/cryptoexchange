module Cryptoexchange::Exchanges
  module Bitfex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitfex::Market::API_URL}/api/3/info".freeze
        def fetch
          super['pairs'].map do |(pair, _info)|
            base, target = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bitfex::Market::NAME
            )
          end
        end
      end
    end
  end
end
