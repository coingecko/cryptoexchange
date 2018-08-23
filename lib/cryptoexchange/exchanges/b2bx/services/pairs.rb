module Cryptoexchange::Exchanges
  module B2bx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::B2bx::Market::API_URL}"

        def fetch
          market_pairs = []
          raw_output = HTTP.use(:auto_inflate).headers("Accept-Encoding" => "gzip").get(PAIRS_URL)
          output = JSON.parse(raw_output)
          output.each do |pair|
            symbol = pair['Instrument']
            base, target = symbol.split(/(BTC$)+|(ETH$)+(.*)|(USDT$)+(.*)|(USD$)+(.*)|(BCH$)+(.*)|(DASH$)+(.*)|(XRP$)+(.*)|(OMG$)+(.*)|(XMR$)+(.*)|(LTC$)+(.*)/)
              market_pairs << Cryptoexchange::Models::MarketPair.new(
                base:   base,
                target: target,
                market: B2bx::Market::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end
