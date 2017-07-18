module Cryptoexchange::Exchanges
  module Lakebtc
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Lakebtc::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.keys.each do |pair|
            if pair.include?('btc')
              market_pairs << Lakebtc::Models::MarketPair.new(
                                base: 'btc',
                                target: pair[3..-1],
                                market: Lakebtc::Market::NAME
                              )
            end
          end

          market_pairs
        end
      end
    end
  end
end
