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
            base = output["b"] == "LINK" ? "LN" : output["b"]
            target = output["a"] == "LINK" ? "LN" : output["a"]

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bitbox::Market::NAME
            )
          end
        end
      end
    end
  end
end
