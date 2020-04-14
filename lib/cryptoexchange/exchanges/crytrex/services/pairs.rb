module Cryptoexchange::Exchanges
  module Crytrex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Crytrex::Market::API_URL}/pairs"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["result"].map do |output|
            Cryptoexchange::Models::MarketPair.new(
              base: output["Currency"],
              target: output["Market"],
              market: Crytrex::Market::NAME
            )
          end
        end
      end
    end
  end
end