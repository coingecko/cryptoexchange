module Cryptoexchange::Exchanges
  module Coinhub
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinhub::Market::API_URL}/coinhub/public/products"

        def fetch
          raw_output = HTTP.get(PAIRS_URL)
          output = JSON.parse(raw_output)
          market_pairs = []
          output['results'].each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              inst_id: pair['id'],
                              base: pair['fromSymbol'],
                              target: pair['toSymbol'],
                              market: Coinhub::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
