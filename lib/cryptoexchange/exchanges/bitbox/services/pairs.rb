module Cryptoexchange::Exchanges
  module Bitbox
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitbox::Market::API_URL}/market/prices"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["responseData"].map do |output|
            Cryptoexchange::Models::MarketPair.new(
              base: output["b"],
              target: output["a"],
              market: Bitbox::Market::NAME
            )
          end
        end
      end
    end
  end
end
