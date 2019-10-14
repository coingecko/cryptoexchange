module Cryptoexchange::Exchanges
  module OasisTrade
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::OasisTrade::Market::API_URL}/markets"

        def fetch
          output = super
          output['data'].map do |pair, ticker|
            base, target = pair.split("/")
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: OasisTrade::Market::NAME
            )
          end
        end
      end
    end
  end
end