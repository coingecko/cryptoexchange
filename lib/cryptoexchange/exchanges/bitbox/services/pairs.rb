module Cryptoexchange::Exchanges
  module Bitbox
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitbox::Market::API_URL}/market/public/coins/pairPolicy"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["responseData"].map do |output|
            target, base = output["coinPairType"].split(".")

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
