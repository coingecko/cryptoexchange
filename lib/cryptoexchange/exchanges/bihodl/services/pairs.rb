module Cryptoexchange::Exchanges
  module Bihodl
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bihodl::Market::API_URL}/symbol-thumb"

        def fetch
          output = super
          output.map do |pair|
            base, target = pair["symbol"].split("/")
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bihodl::Market::NAME
            )
          end
        end
      end
    end
  end
end
