module Cryptoexchange::Exchanges
  module Bitstorage
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitstorage::Market::API_URL}/ticker"

        def fetch
          output = super
          output.map do |pair, ticker|
            base, target = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bitstorage::Market::NAME
            )
          end
        end
      end
    end
  end
end
