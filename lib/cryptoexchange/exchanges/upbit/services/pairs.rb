module Cryptoexchange::Exchanges
  module Upbit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Upbit::Market::PAIRS_URL}"

        def fetch
          raw_output = HTTP.use(:auto_inflate).headers("Accept-Encoding" => "gzip").get(PAIRS_URL)
          output     = JSON.parse(raw_output)
          output.map do |pair|
            if pair['marketState'] == "ACTIVE"
              Cryptoexchange::Models::MarketPair.new(
                base:   pair["baseCurrencyCode"],
                target: pair["quoteCurrencyCode"],
                market: Upbit::Market::NAME)
            else
              nil
            end
          end.compact
        end
      end
    end
  end
end
