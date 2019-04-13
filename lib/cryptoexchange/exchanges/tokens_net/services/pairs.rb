module Cryptoexchange::Exchanges
  module TokensNet
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::TokensNet::Market::API_URL}/public/trading-pairs/get/all/"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair, ticker|
            base, target = ticker['title'].split('/')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: TokensNet::Market::NAME
            )
          end
        end
      end
    end
  end
end
