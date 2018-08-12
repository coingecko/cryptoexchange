module Cryptoexchange::Exchanges
  module Sapotaexchange
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Sapotaexchange::Market::API_URL}/ticker"

        def fetch
          raw_output = HTTP.get(PAIRS_URL)
          output = JSON.parse(raw_output)
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['base'],
                              target: pair['counter'],
                              market: Sapotaexchange::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
