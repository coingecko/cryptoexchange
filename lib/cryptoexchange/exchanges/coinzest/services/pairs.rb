module Cryptoexchange::Exchanges
  module Coinzest
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinzest::Market::API_URL}/market"

        def fetch
          ctx = OpenSSL::SSL::SSLContext.new
          ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE
          result = HTTP.get(PAIRS_URL, ssl_context: ctx)
          output = JSON.parse(result)
          market_pairs = []
          output['list'].each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['trdCoinName'],
                              target: pair['mrkCoinName'],
                              inst_id: "#{pair['mrkCoin']}-#{pair['trdCoin']}",
                              market: Coinzest::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
