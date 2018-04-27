module Cryptoexchange::Exchanges
  module Kkcoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Kkcoin::Market::API_URL}/allticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |price|
            base, target = price[0].split("_")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Kkcoin::Market::NAME
            )
          end
        end
      end
    end
  end
end
