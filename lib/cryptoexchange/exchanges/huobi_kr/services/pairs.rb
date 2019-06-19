module Cryptoexchange::Exchanges
  module HuobiKr
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::HuobiKr::Market::API_URL}/v1/common/symbols"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            next if pair["state"] == "offline"
            Cryptoexchange::Models::MarketPair.new({
              base: pair['base-currency'],
              target: pair['quote-currency'],
              market: HuobiKr::Market::NAME
            })
          end.compact
        end
      end
    end
  end
end
