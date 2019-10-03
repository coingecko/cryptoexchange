module Cryptoexchange::Exchanges
  module Decoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Decoin::Market::API_URL}/market/get-ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair['Name'].split("/")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Decoin::Market::NAME
            )
          end
        end
      end
    end
  end
end
 