module Cryptoexchange::Exchanges
  module Huobi
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URLS = [
          "#{Cryptoexchange::Exchanges::Huobi::Market::DOT_PRO_API_URL}/v1/common/symbols"
        ]

        def fetch
          PAIRS_URLS.map do |endpoint|
            output = fetch_via_api(endpoint)
            adapt(output)
          end.flatten
        end

        def adapt(output)
          output['data'].map do |pair|
            Cryptoexchange::Models::MarketPair.new({
              base: pair['base-currency'],
              target: pair['quote-currency'],
              market: Huobi::Market::NAME
            })
          end
        end
      end
    end
  end
end
