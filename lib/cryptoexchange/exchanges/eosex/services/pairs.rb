module Cryptoexchange::Exchanges
  module Eosex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Eosex::Market::API_URL}"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output["msg"]
          market_pairs = []
          pairs.each do |pair|
            base, target = pair["Symbol"].split('/')
            market_pairs <<
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Eosex::Market::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end
