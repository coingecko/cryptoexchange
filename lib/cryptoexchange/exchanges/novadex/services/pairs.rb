module Cryptoexchange::Exchanges
  module Novadex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Novadex::Market::API_URL}/all_price_ticker.php"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair, _ticker|
            base, target = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Novadex::Market::NAME
            )
          end
        end
      end
    end
  end
end
