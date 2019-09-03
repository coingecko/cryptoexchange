module Cryptoexchange::Exchanges
  module OkexKorea
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::OkexKorea::Market::API_URL}/instruments/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair['product_id'].split("-")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: OkexKorea::Market::NAME
            )
          end
        end
      end
    end
  end
end
