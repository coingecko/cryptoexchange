module Cryptoexchange::Exchanges
  module Coinzest
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinzest::Market::API_URL}/market_summary"

        def fetch
          ctx = OpenSSL::SSL::SSLContext.new
          ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE
          result = HTTP.get(PAIRS_URL, ssl_context: ctx)
          output = JSON.parse(result)
          output['result'].map do |pair|
            target, base = pair['MarketName'].split('-')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Coinzest::Market::NAME
            )
          end
        end
      end
    end
  end
end
