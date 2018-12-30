module Cryptoexchange::Exchanges
  module Xs2
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Xs2::Market::API_URL}/btx/v1.1/public/getmarketsummaries"

        def fetch
          output = super
          market_pairs = []
          output['result'].each do |pair|
            target, base = pair['MarketName'].split('-')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Xs2::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
