module Cryptoexchange::Exchanges
  module Ironex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Ironex::Market::API_URL}/all_price_ticker.php"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair[0].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base.upcase,
                              target: target.upcase,
                              market: Ironex::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
