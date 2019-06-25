module Cryptoexchange::Exchanges
  module HuobiJapan
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::HuobiJapan::Market::API_URL}/v1/common/symbols"

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
              market: HuobiJapan::Market::NAME
            })
          end.compact
        end
      end
    end
  end
end
