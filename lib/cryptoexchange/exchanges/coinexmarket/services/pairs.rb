module Cryptoexchange::Exchanges
  module Coinexmarket
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinexmarket::Market::API_URL}/availablepairs"

        def fetch
          output = super
          adapt(output['combinations'])
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair.split("_")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Coinexmarket::Market::NAME
            )
          end
        end
      end
    end
  end
end
