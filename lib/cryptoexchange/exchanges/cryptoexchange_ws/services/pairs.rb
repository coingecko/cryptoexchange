module Cryptoexchange::Exchanges
  module CryptoexchangeWs
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::CryptoexchangeWs::Market::API_URL}/public/returnTicker"

        def fetch
          output = super
          market_pairs = []
          output['results'].each do |pair|
            base, target = pair[0].split('-')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: CryptoexchangeWs::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
