module Cryptoexchange::Exchanges
  module GoExchange
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::GoExchange::Market::API_URL}/exchange/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["result"].map do |pair|
            base, target = GoExchange::Market.separate_symbol(pair["symbol"])
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: GoExchange::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
