module Cryptoexchange::Exchanges
  module BitmaxFutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::BitmaxFutures::Market::API_URL}/ticker?symbol=BTC-PERP"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          base, target = output["data"]["symbol"].split('-')
          market_pairs << Cryptoexchange::Models::MarketPair.new(
            base: base,
            target: "USDT",
            contract_interval: "perpetual",
            inst_id: output["data"]["symbol"],
            market: BitmaxFutures::Market::NAME
          )
          market_pairs
        end
      end
    end
  end
end
