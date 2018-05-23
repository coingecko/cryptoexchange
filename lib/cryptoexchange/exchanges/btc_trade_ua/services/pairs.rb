module Cryptoexchange::Exchanges
  module BtcTradeUa
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::BtcTradeUa::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair, _value|
            base, target = pair.split("_")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: BtcTradeUa::Market::NAME
            )
          end
        end
      end
    end
  end
end
