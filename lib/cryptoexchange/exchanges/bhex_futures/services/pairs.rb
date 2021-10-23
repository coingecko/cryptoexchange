module Cryptoexchange::Exchanges
  module BhexFutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::BhexFutures::Market::API_URL}/contract/ticker/24hr"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |ticker|
            base, target = ticker["symbol"].split("-") 
            next if ticker["symbol"].include?("USDT") || ticker["symbol"].include?("PERP")
            target = "USDT"

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              inst_id: ticker["symbol"],
              contract_interval: "perpetual",
              market: BhexFutures::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
