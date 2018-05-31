module Cryptoexchange::Exchanges
  module Oasisdex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Oasisdex::Market::API_URL}/pairs/"

        def fetch
          output = super
          market_pairs = []
          output['data'].each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair[1]['base'],
                              target: pair[1]['quote'],
                              market: Oasisdex::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
