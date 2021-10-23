module Cryptoexchange::Exchanges
  module Bitasset
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitasset::Market::API_URL}/tickers"

        def fetch
          ctx = OpenSSL::SSL::SSLContext.new
          ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE

          output = Cryptoexchange::Cache.ticker_cache.fetch(PAIRS_URL) do
            HTTP.get(PAIRS_URL, ssl_context: ctx).parse(:json)
          end

          market_pairs = []
          output["ticker"].each do |pair|
            base, target = pair["symbol"].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base.upcase,
                              target: target.upcase,
                              market: Bitasset::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
