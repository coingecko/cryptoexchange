module Cryptoexchange::Exchanges
  module Coincheck
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coincheck::Market::API_URL}/ticker?pair=ltc_jpy"

        # NOTE: Currently only BTC JPY is supported in the ticker API.
        def fetch
          [
            Coincheck::Models::MarketPair.new(
              base: 'BTC',
              target: 'JPY',
              market: Coincheck::Market::NAME
            )
          ]
        end
      end
    end
  end
end
