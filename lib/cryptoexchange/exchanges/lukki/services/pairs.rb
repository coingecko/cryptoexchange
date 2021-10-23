module Cryptoexchange::Exchanges
  module Lukki
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Lukki::Market::API_URL}/trading/tickers"

        def fetch
          ctx = OpenSSL::SSL::SSLContext.new
          ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE

          output = Cryptoexchange::Cache.ticker_cache.fetch(PAIRS_URL) do
            HTTP.get(PAIRS_URL, ssl_context: ctx).parse(:json)
          end
          adapt(output)
        end

        def adapt(output)
          output.map do |ticker|
            base, target = ticker['ticker'].split("_")
            Cryptoexchange::Models::MarketPair.new({
              base: base,
              target: target,
              market: Lukki::Market::NAME
            })
          end
        end
      end
    end
  end
end
