module Cryptoexchange::Exchanges
  module HuobiId
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::HuobiId::Market::API_URL}/market/tickers"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            base, target = HuobiId::Market.separate_symbol(pair["symbol"])
            Cryptoexchange::Models::MarketPair.new({
              base: base,
              target: target,
              market: HuobiId::Market::NAME
            })
          end
        end
      end
    end
  end
end
