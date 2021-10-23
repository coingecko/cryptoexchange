module Cryptoexchange::Exchanges
  module Btcmex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Btcmex::Market::API_URL}/ticker"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair, _ticker|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair.split("USD")[0],
                              target: "USD",
                              inst_id: pair,
                              contract_interval: "perpetual",
                              market: Btcmex::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
