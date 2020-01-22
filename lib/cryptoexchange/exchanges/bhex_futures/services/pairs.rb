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
            next if ticker["symbol"].include? "PERP"

            if !ticker["symbol"].include? "-SWAP"    
              base, target = ticker["symbol"].split("-SWAP-") 
            else
              base, target = ticker["symbol"].split("-") 
              target = "USDT"
            end

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
