module Cryptoexchange::Exchanges
  module Coinfalcon
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinfalcon::Market::API_URL}markets"

        def fetch
          output = super
          adapt(output['data'])
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            pair_split = pair['name'].split('-')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair_split[0],
                              target: pair_split[1],
                              market: Coinfalcon::Market::NAME
                            )
          end
          
          market_pairs
        end
      end
    end
  end
end
