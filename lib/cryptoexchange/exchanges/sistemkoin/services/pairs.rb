module Cryptoexchange::Exchanges
  module Sistemkoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs

        PAIRS_URL = "#{Cryptoexchange::Exchanges::Sistemkoin::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output['data'].each do |based, pair|
            pair.each do |pair|
              market_pairs << Cryptoexchange::Models::MarketPair.new(
                                base: pair['short_code'],
                                target: pair['currency'],
                                market: Sistemkoin::Market::NAME)
            end
          end
          market_pairs
        end
      end
    end
  end
end