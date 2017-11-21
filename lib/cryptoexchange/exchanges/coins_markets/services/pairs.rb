module Cryptoexchange::Exchanges
  module CoinsMarkets
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::CoinsMarkets::Market::API_URL}/apicoin.php"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |key, _|
            target, base = key.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: CoinsMarkets::Market::NAME
            )
          end
        end
      end
    end
  end
end
