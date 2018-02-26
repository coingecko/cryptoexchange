module Cryptoexchange::Exchanges
  module Upbit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Upbit::Market::PAIRS_URL}"

        def fetch
          raw_output = HTTP.use(:auto_inflate).headers("Accept-Encoding" => "gzip").get(PAIRS_URL)
          output = JSON.parse(raw_output)
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair["baseCurrencyCode"],
                              target: pair["quoteCurrencyCode"],
                              market: Upbit::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
