module Cryptoexchange::Exchanges
  module Aex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URLS = [
          "#{Cryptoexchange::Exchanges::Aex::Market::API_URL}/ticker.php?c=all&mk_type=btc",
          "#{Cryptoexchange::Exchanges::Aex::Market::API_URL}/ticker.php?c=all&mk_type=bitcny",
          "#{Cryptoexchange::Exchanges::Aex::Market::API_URL}/ticker.php?c=all&mk_type=bitusd"
        ]

        def fetch
          PAIRS_URLS.map do |endpoint|
            output = fetch_via_api(endpoint)
            target = endpoint.split("=").last
            adapt(output, target)
          end.flatten
        end

        def adapt(output, target)
          pairs = []
          output.each do |key, value|
            pairs << Cryptoexchange::Models::MarketPair.new(
              base: key,
              target: target,
              market: Aex::Market::NAME
            )
          end
          pairs 
        end
      end
    end
  end
end
