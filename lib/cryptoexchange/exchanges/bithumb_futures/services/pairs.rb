module Cryptoexchange::Exchanges
  module BithumbFutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::BithumbFutures::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["data"].map do |output|
            base = output["symbol"].chomp("-PERP") 
            target = "USDT"
            
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              contract_interval: "perpetual",
              inst_id: output["symbol"],
              market: BithumbFutures::Market::NAME
            )
          end
        end
      end
    end
  end
end
