module Cryptoexchange::Exchanges
  module Allcoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Allcoin::Market::API_URL}/Api_Market/getPriceList"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |coin|
            coin.drop(1).flatten.each do |pair|
              market_pairs << Cryptoexchange::Models::MarketPair.new(
                                base: pair['coin_from'].upcase,
                                target: pair['coin_to'].upcase,
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
