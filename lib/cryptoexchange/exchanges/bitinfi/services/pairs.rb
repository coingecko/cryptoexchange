module Cryptoexchange::Exchanges
  module Bitinfi
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitinfi::Market::API_URL}/product.ashx?lang=en&packtype=1&version=9.9.9"

        def fetch
          output = super
          market_pairs = []
          output['data'].each do |pair|
            base, target = pair['symbol'].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Bitinfi::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
