module Cryptoexchange::Exchanges
  module Bitcoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitcoin::Market::API_URL}/symbol"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair["baseCurrency"],
                              target: pair["quoteCurrency"],
                              market: Bitcoin::Market::NAME,
                            )
          end
          market_pairs
        end
      end
    end
  end
end
