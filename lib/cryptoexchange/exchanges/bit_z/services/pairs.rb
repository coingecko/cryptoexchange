module Cryptoexchange::Exchanges
  module BitZ
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::BitZ::Market::API_URL}/tickerall"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          pairs = output["data"]
          pairs.each_key do |pair|
            base = pair.split("_").first
            target = pair.split("_").last
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: BitZ::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
