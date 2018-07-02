module Cryptoexchange::Exchanges
  module Myspeedtrade
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Myspeedtrade::Market::API_URL}/markets"

        def fetch
          ctx = OpenSSL::SSL::SSLContext.new
          ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE
          result = HTTP.get(PAIRS_URL, ssl_context: ctx)
          output = JSON.parse(result)
          market_pairs = []
          output.each do |pair|
            base, target = pair['name'].split('/')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Myspeedtrade::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
