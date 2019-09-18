module Cryptoexchange::Exchanges
  module CmeFutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::CmeFutures::Market::API_URL}/CmeWS/mvc/Quotes/Future/8478/G?pageSize=500&_=1564549645686"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output["quotes"].each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair["productCode"],
                              target: "USD",
                              market: CmeFutures::Market::NAME,
                              contract_interval: pair["expirationMonth"]
                            )
          end

          market_pairs
        end
      end
    end
  end
end
