module Cryptoexchange::Exchanges
  module Xbit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Xbit::Market::API_URL}/pairs"

        def fetch
          response = super
          adapt(response)
        end

        def adapt(output)
          output.collect do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base: pair[0],
              target: pair[1],
              market: Xbit::Market::NAME
            )
          end
        end
      end
    end
  end
end