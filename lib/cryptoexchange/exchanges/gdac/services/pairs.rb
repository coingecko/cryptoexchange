module Cryptoexchange::Exchanges
  module Gdac
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Gdac::Market::API_URL}/public/marketsummaries"

        def fetch
          ctx = OpenSSL::SSL::SSLContext.new
          ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE
          result = HTTP.get(PAIRS_URL, ssl_context: ctx)
          output = JSON.parse(result)

          market_pairs = []
          pairs = output['result'].map { |r| r["marketName"].split("-") }
          pairs.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair.last,
                              target: pair.first,
                              market: Gdac::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
