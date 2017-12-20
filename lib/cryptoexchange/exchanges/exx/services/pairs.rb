module Cryptoexchange::Exchanges
  module Exx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Exx::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = []
          output.each_key do |pair|
            base, target = pair.split("_")
            pairs << Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Exx::Market::NAME
          )
          end
          pairs
        end
      end
    end
  end
end
