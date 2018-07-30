module Cryptoexchange::Exchanges
  module Allcoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Allcoin::Market::API_URL}/Api_Market/getPriceList"

        def fetch
          output = fetch_via_api_using_post
          market_pairs = []
          output.each do |key, value|
            value.each do |pairs|
              base = pairs["coin_from"]
              target = key
              market_pairs << Cryptoexchange::Models::MarketPair.new(
                                base: base,
                                target: target,
                                market: Allcoin::Market::NAME
                              )
            end
          end
          market_pairs
        end
      end
    end
  end
end
