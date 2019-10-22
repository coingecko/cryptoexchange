module Cryptoexchange::Exchanges
  module BitfinexFutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::BitfinexFutures::Market::API_URL}/status/deriv?keys=ALL"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            pair = pair[0]

            next if pair[0] != 't'

            if pair.include? ":"
              base, target = pair.split(":")
              base = base[1..-3]
              target = if target.include?("US")
                "USD"
              else
                target
              end
            end

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              inst_id: pair,
              contract_interval: "perpetual",
              market: BitfinexFutures::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
