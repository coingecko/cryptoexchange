module Cryptoexchange::Exchanges
  module Bakkt
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bakkt::Market::API_URL}/DelayedMarkets.shtml?getContractsAsJson=&productId=23808&hubId=26066"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: "BTC",
                              target: "USD",
                              market: Bakkt::Market::NAME,
                              contract_interval: pair["marketStrip"],
                              inst_id: pair["marketId"].to_s,
                            )
          end
          market_pairs
        end
      end
    end
  end
end
