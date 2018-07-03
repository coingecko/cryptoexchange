module Cryptoexchange::Exchanges
  module Otcbtc
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Otcbtc::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair["name"].split("/").first,
                              target: pair["name"].split("/").last,
                              market: Otcbtc::Market::NAME
                            )
          end

          market_pairs
        end
      end
    end
  end
end
